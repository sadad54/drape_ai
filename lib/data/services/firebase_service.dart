import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'dart:typed_data';

import '../models/user_model.dart';
import '../models/clothing_item_model.dart';
import '../models/outfit_model.dart';

class FirebaseService {
  FirebaseService._();
  static final FirebaseService instance = FirebaseService._();

  // Collection References
  static CollectionReference get users =>
      FirebaseFirestore.instance.collection(usersCollection);

  static CollectionReference get clothingItems =>
      FirebaseFirestore.instance.collection(clothingItemsCollection);

  static CollectionReference get outfits =>
      FirebaseFirestore.instance.collection(outfitsCollection);

  static CollectionReference get trends =>
      FirebaseFirestore.instance.collection(trendsCollection);

  // Error handling helper
  static String handleFirestoreError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'Permission denied. Please check your authentication.';
      case 'unavailable':
        return 'Service temporarily unavailable. Please try again.';
      case 'not-found':
        return 'Document not found.';
      case 'already-exists':
        return 'Document already exists.';
      case 'resource-exhausted':
        return 'Quota exceeded. Please try again later.';
      case 'failed-precondition':
        return 'Operation failed due to precondition.';
      case 'aborted':
        return 'Operation was aborted. Please try again.';
      case 'out-of-range':
        return 'Invalid range specified.';
      case 'unimplemented':
        return 'Operation not implemented.';
      case 'internal':
        return 'Internal server error. Please try again.';
      case 'deadline-exceeded':
        return 'Operation timed out. Please try again.';
      case 'unauthenticated':
        return 'User not authenticated. Please sign in.';
      default:
        return e.message ?? 'An unknown error occurred.';
    }
  }

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Collections
  static const String usersCollection = 'users';
  static const String clothingItemsCollection = 'clothing_items';
  static const String outfitsCollection = 'outfits';
  static const String trendsCollection = 'trends';
  static const String feedCollection = 'feed';

  // Auth Methods
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in was cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // User Data Methods
  Future<void> createUserDocument(UserModel user) async {
    await _firestore
        .collection(usersCollection)
        .doc(user.id)
        .set(user.toJson());
  }

  Future<UserModel?> getUserData(String userId) async {
    final doc = await _firestore.collection(usersCollection).doc(userId).get();

    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    await _firestore.collection(usersCollection).doc(userId).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Stream<UserModel?> watchUserData(String userId) {
    return _firestore
        .collection(usersCollection)
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    });
  }

  // Clothing Items Methods
  Future<String> addClothingItem(ClothingItemModel item) async {
    final docRef = _firestore.collection(clothingItemsCollection).doc();
    final itemWithId = item.copyWith(
      id: docRef.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await docRef.set(itemWithId.toJson());
    return docRef.id;
  }

  Future<void> updateClothingItem(ClothingItemModel item) async {
    await _firestore.collection(clothingItemsCollection).doc(item.id).update({
      ...item.toJson(),
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteClothingItem(String itemId) async {
    await _firestore.collection(clothingItemsCollection).doc(itemId).delete();
  }

  Stream<List<ClothingItemModel>> watchUserClothingItems(String userId) {
    return _firestore
        .collection(clothingItemsCollection)
        .where('user_id', isEqualTo: userId)
        .where('is_visible', isEqualTo: true)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ClothingItemModel.fromJson(doc.data()))
          .toList();
    });
  }

  Future<List<ClothingItemModel>> getUserClothingItems(
    String userId, {
    ClothingCategory? category,
    int? limit,
  }) async {
    Query query = _firestore
        .collection(clothingItemsCollection)
        .where('user_id', isEqualTo: userId)
        .where('is_visible', isEqualTo: true);

    if (category != null) {
      query = query.where('category', isEqualTo: category.name);
    }

    query = query.orderBy('created_at', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) =>
            ClothingItemModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Outfits Methods
  Future<String> addOutfit(OutfitModel outfit) async {
    final docRef = _firestore.collection(outfitsCollection).doc();
    final outfitWithId = outfit.copyWith(
      id: docRef.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await docRef.set(outfitWithId.toJson());
    return docRef.id;
  }

  Future<void> updateOutfit(OutfitModel outfit) async {
    await _firestore.collection(outfitsCollection).doc(outfit.id).update({
      ...outfit.toJson(),
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteOutfit(String outfitId) async {
    await _firestore.collection(outfitsCollection).doc(outfitId).delete();
  }

  Stream<List<OutfitModel>> watchUserOutfits(String userId) {
    return _firestore
        .collection(outfitsCollection)
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => OutfitModel.fromJson(doc.data()))
          .toList();
    });
  }

  Future<List<OutfitModel>> getPublicOutfits({
    int? limit,
    DocumentSnapshot? lastDocument,
  }) async {
    Query query = _firestore
        .collection(outfitsCollection)
        .where('is_public', isEqualTo: true)
        .orderBy('likes', descending: true)
        .orderBy('created_at', descending: true);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => OutfitModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Storage Methods
  Future<String> uploadImage({
    required String path,
    required String fileName,
    File? file,
    Uint8List? bytes,
  }) async {
    final ref = _storage.ref().child(path).child(fileName);

    UploadTask uploadTask;
    if (file != null) {
      uploadTask = ref.putFile(file);
    } else if (bytes != null) {
      uploadTask = ref.putData(bytes);
    } else {
      throw ArgumentError('Either file or bytes must be provided');
    }

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> deleteImage(String imageUrl) async {
    try {
      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      // Image might not exist, log but don't throw
      print('Error deleting image: $e');
    }
  }

  // Batch Operations
  Future<void> batchWrite(List<Map<String, dynamic>> operations) async {
    final batch = _firestore.batch();

    for (final operation in operations) {
      final type = operation['type'] as String;
      final collection = operation['collection'] as String;
      final docId = operation['docId'] as String?;
      final data = operation['data'] as Map<String, dynamic>?;

      final docRef = docId != null
          ? _firestore.collection(collection).doc(docId)
          : _firestore.collection(collection).doc();

      switch (type) {
        case 'set':
          batch.set(docRef, data!);
          break;
        case 'update':
          batch.update(docRef, data!);
          break;
        case 'delete':
          batch.delete(docRef);
          break;
      }
    }

    await batch.commit();
  }

  // Helper method to handle authentication exceptions
  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found with this email address.');
      case 'wrong-password':
        return Exception('Incorrect password.');
      case 'email-already-in-use':
        return Exception('An account already exists with this email address.');
      case 'weak-password':
        return Exception('Password is too weak.');
      case 'invalid-email':
        return Exception('Email address is invalid.');
      case 'user-disabled':
        return Exception('This account has been disabled.');
      case 'too-many-requests':
        return Exception('Too many failed attempts. Please try again later.');
      case 'operation-not-allowed':
        return Exception('This operation is not allowed.');
      default:
        return Exception('Authentication failed: ${e.message}');
    }
  }
}
