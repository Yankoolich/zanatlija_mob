import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zanatlija_app/data/models/craft.dart';
import 'package:zanatlija_app/data/models/user.dart';
import 'package:zanatlija_app/utils/app_mixin.dart';

enum LoginError {
  userNotFound,
  passwordIsWrong,
  unknownError,
}

class FirestoreService with AppMixin {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  final kUserCollection = 'users';
  final kCraftCollection = 'crafts';

  Future<void> createUser(User user) async {
    final collectionReference = firestoreInstance.collection(kUserCollection);
    await collectionReference.doc(user.phoneNumber).set(user.toJson());
  }

  Future<List<Craft>> getAllCrafts(User user) async {
    List<Craft> crafts = [];
    try {
      final collectionReference =
          firestoreInstance.collection(kCraftCollection);
      final data = await collectionReference.get();

      for (final doc
          in data.docs.where((e) => e.id != user.phoneNumber).toList()) {
        crafts.add(Craft.fromJson(doc.data()));
      }
      return crafts;
    } catch (error) {
      return crafts;
    }
  }

  Future<User?> login(String phoneNumber, String password) async {
    try {
      final hashedPassword = getHashedPassword(password);
      final userDoc = await firestoreInstance
          .collection(kUserCollection)
          .doc(phoneNumber)
          .get();

      if (userDoc.exists) {
        if (userDoc['password'] == hashedPassword) {
          return User.fromJson(userDoc.data()!);
        } else {
          throw LoginError.passwordIsWrong;
        }
      }
      throw LoginError.userNotFound;
    } catch (e) {
      throw LoginError.unknownError;
    }
  }

  Future<void> addCraftToUser(Craft craft, User user) async {
    try {
      final userCollectionReference =
          firestoreInstance.collection(kUserCollection);
      final craftCollectionReference =
          firestoreInstance.collection(kCraftCollection);

      user.myJobs?.add(craft);
      await Future.wait([
        userCollectionReference.doc(user.phoneNumber).update(user.toJson()),
        craftCollectionReference.doc().set(craft.toJson())
      ]);
    } catch (error) {}
  }
}
