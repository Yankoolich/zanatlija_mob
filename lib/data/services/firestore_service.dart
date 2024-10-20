import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:zanatlija_app/entities/login/models/user.dart';

class FirestoreService {
  final FirebaseFirestore firebaseFirestoreInstance;
  FirestoreService(this.firebaseFirestoreInstance);
  final kUserCollection = 'users';

  Future<void> createUser(User user) async {
    final collectionReference =
        firebaseFirestoreInstance.collection(kUserCollection);
    await collectionReference
        .doc(user.phoneNumber.toString())
        .set(user.toJson());
  }

  Future<bool> login(String email, String password) async {
    try {
      final hashedPassword = _hashPassword(password);
      DocumentSnapshot userDoc =
          await firebaseFirestoreInstance.collection('users').doc(email).get();
      if (userDoc.exists) {
        if (userDoc['password'] == hashedPassword) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
