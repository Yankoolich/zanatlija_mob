import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zanatlija_app/entities/login/models/user.dart';
import 'package:zanatlija_app/utils/app_mixin.dart';

enum LoginError {
  userNotFound,
  passwordIsWrong,
  unknownError,
}

class FirestoreService with AppMixin {
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

  Future<LoginError?> login(String phoneNumber, String password) async {
    try {
      final hashedPassword = getHashedPassword(password);
      final userDoc = await firebaseFirestoreInstance
          .collection(kUserCollection)
          .doc(phoneNumber)
          .get();
      if (userDoc.exists) {
        if (userDoc['password'] == hashedPassword) {
          return null;
        } else {
          return LoginError.passwordIsWrong;
        }
      }
      return LoginError.userNotFound;
    } catch (e) {
      return LoginError.unknownError;
    }
  }
}
