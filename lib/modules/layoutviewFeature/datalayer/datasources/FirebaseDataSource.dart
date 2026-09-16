import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/UserModel.dart';

class FirebaseDataSource {
  static CollectionReference<UserModel> getcollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionname)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromjson(snapshot.data()!),
          toFirestore: (data, options) => data.tofirestore(),
        );
  }

  static Future<bool> editprofileimage(String image, String userID) async {
    try {
      final collectionref = getcollection();
      final docRef = collectionref.doc(userID);
      await docRef.update({'image': image});
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> editprofilename(String name, String userID) async {
    try {
      final collectionref = getcollection();
      final docRef = collectionref.doc(userID);
      await docRef.update({'name': name});
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> editprofilephone(String phone, String userID) async {
    try {
      final collectionref = getcollection();
      final docRef = collectionref.doc(userID);
      await docRef.update({'phone': phone});
      return true;
    } catch (error) {
      return false;
    }
  }
}