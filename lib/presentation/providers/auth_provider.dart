import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/services/firebase_service.dart';
import '../../data/models/user_model.dart';

part 'auth_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserModel user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.initial()) {
    _initializeAuth();
  }

  final FirebaseService _firebaseService = FirebaseService.instance;

  void _initializeAuth() {
    _firebaseService.authStateChanges.listen((User? user) async {
      if (user != null) {
        final userData = await _firebaseService.getUserData(user.uid);
        if (userData != null) {
          state = AuthState.authenticated(userData);
        } else {
          // Create user document if it doesn't exist
          final newUser = UserModel(
            id: user.uid,
            email: user.email ?? '',
            displayName: user.displayName ?? '',
            photoURL: user.photoURL,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await _firebaseService.createUserDocument(newUser);
          state = AuthState.authenticated(newUser);
        }
      } else {
        state = const AuthState.unauthenticated();
      }
    });
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      state = const AuthState.loading();
      await _firebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // State will be updated automatically through auth state changes listener
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      state = const AuthState.loading();
      final credential = await _firebaseService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await credential.user?.updateDisplayName(displayName);

      // Create user document
      final user = UserModel(
        id: credential.user!.uid,
        email: email,
        displayName: displayName,
        photoURL: credential.user?.photoURL,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firebaseService.createUserDocument(user);
      // State will be updated automatically through auth state changes listener
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = const AuthState.loading();
      await _firebaseService.signInWithGoogle();
      // State will be updated automatically through auth state changes listener
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseService.signOut();
      // State will be updated automatically through auth state changes listener
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseService.sendPasswordResetEmail(email);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
    FashionArchetype? fashionArchetype,
    UserPreferences? preferences,
    UserLocation? location,
    bool? isOnboardingComplete,
  }) async {
    state.maybeWhen(
      authenticated: (user) async {
        try {
          final updates = <String, dynamic>{};

          if (displayName != null) updates['displayName'] = displayName;
          if (photoURL != null) updates['photoURL'] = photoURL;
          if (fashionArchetype != null) {
            updates['fashionArchetype'] = fashionArchetype.toJson();
          }
          if (preferences != null) {
            updates['preferences'] = preferences.toJson();
          }
          if (location != null) {
            updates['location'] = location.toJson();
          }
          if (isOnboardingComplete != null) {
            updates['isOnboardingComplete'] = isOnboardingComplete;
          }
          updates['displayName'] = displayName;
          if (photoURL != null) updates['photoURL'] = photoURL;
          if (fashionArchetype != null) {
            updates['fashionArchetype'] = fashionArchetype.toJson();
          }
          if (preferences != null) {
            updates['preferences'] = preferences.toJson();
          }
          if (location != null) {
            updates['location'] = location.toJson();
          }
          if (isOnboardingComplete != null) {
            updates['isOnboardingComplete'] = isOnboardingComplete;
          }

          await _firebaseService.updateUserData(user.id, updates);

          // Update local state
          final updatedUser = user.copyWith(
            displayName: displayName ?? user.displayName,
            photoURL: photoURL ?? user.photoURL,
            fashionArchetype: fashionArchetype ?? user.fashionArchetype,
            preferences: preferences ?? user.preferences,
            location: location ?? user.location,
            isOnboardingComplete:
                isOnboardingComplete ?? user.isOnboardingComplete,
            updatedAt: DateTime.now(),
          );

          state = AuthState.authenticated(updatedUser);
        } catch (e) {
          state = AuthState.error(e.toString());
        }
      },
      orElse: () {
        state = const AuthState.error('User not authenticated');
      },
    );
  }

  void clearError() {
    state.maybeWhen(
      error: (_) => state = const AuthState.unauthenticated(),
      orElse: () {},
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Helper providers
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
});

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    loading: () => true,
    orElse: () => false,
  );
});
