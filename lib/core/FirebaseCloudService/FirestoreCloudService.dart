import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../modules/layoutviewFeature/datalayer/Models/UserModel.dart';

class FirestoreCloudService {
  static CollectionReference<UserModel> getcollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionname)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromjson(snapshot.data()!),
          toFirestore: (data, options) => data.tofirestore(),
        );
  }

  static Future<bool> createuser(UserModel user) async {
    try {
      final collectionref = getcollection();
      final docRef = collectionref.doc(user.userID);

      await docRef.set(user);

      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> updateuser(UserModel user) async {
    try {
      final collectionref = getcollection();
      final docRef = collectionref.doc(user.userID);
      await docRef.update(user.tofirestore());
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> deleteAccount(String userID) async {
    try {
      final collectionref = getcollection();

      final docRef = collectionref.doc(userID);
      await docRef.delete();
      await FirebaseAuth.instance.currentUser?.delete();


      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<UserModel?> getuser(String userID) async {
    try {
      final collectionref = getcollection();

      final docRef = await collectionref.doc(userID);

      final user = await docRef.get();

      if (user.exists) {
        return user.data();
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
