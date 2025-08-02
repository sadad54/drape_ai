import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class UserRepository {
  // Create user
  Future<void> createUser(UserModel user) async {
    try {
      await FirebaseService.users.doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw Exception(FirebaseService.handleFirestoreError(e));
    }
  }

  // Get user by ID
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await FirebaseService.users.doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception(FirebaseService.handleFirestoreError(e));
    }
  }

  // Update user
  Future<void> updateUser(UserModel user) async {
    try {
      await FirebaseService.users.doc(user.id).update(
        user.copyWith(updatedAt: DateTime.now()).toJson(),
      );
    } on FirebaseException catch (e) {
      throw Exception(FirebaseService.handleFirestoreError(e));
    }
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseService.users.doc(userId).delete();
    } on FirebaseException catch (e) {
      throw Exception(FirebaseService.handleFirestoreError(e));
    }
  }

  // Update user preferences
  Future<void> updateUserPreferences(String userId, UserPreferences preferences) async {
    try {
      await FirebaseService.users.doc(userId).update({
        'preferences': preferences.toJson(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } on FirebaseException catch (e) {
      throw Exception(FirebaseService.handleFirestoreError(e));
    }
  }

  // Update fashion archetype
  Future<void> updateFashionArchetype(String userId, FashionArchetype archetype) async {
    try {
      await FirebaseService.users.doc(userId).update({
        'fashion_archetype': archetype.toJson(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } on FirebaseException catch (e) {
      throw Exception(FirebaseService.handleFirestoreError(e));
    }
  }

  // Update location
  Future<void> updateUserLocation(String userId, UserLocation location) async {
    try {
      await FirebaseService.users.doc(userId).update({
        'location': location.toJson(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } on FirebaseException catch (e) {
      throw Exception(FirebaseService.handleFirestoreError(e));
    }
  }

  // Complete onboarding
  Future<void> completeOnboarding(String userId) async {
    try {
      await FirebaseService.users.doc(userId).update({
        'is_onboarding_complete': true,
        'updated_at': DateTime.now().toIso8601String(),
      }); 