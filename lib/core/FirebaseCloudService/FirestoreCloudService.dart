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

  static Future<bool> addFavoriteMovie(String movieID) async {
    try {
      final userID = FirebaseAuth.instance.currentUser?.uid;
      final collectionRef = getcollection();

      final docRef = collectionRef.doc(userID);

      await docRef.update({
        'favoriteMovies': FieldValue.arrayUnion([movieID]),
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> removeFavoriteMovie(String movieID) async {
    try {
      final userID = FirebaseAuth.instance.currentUser?.uid;
      final collectionRef = getcollection();

      final docRef = collectionRef.doc(userID);

      await docRef.update({
        'favoriteMovies': FieldValue.arrayRemove([movieID]),
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<List<String>> getFavoriteMovies() async {
    try {
      final userID = FirebaseAuth.instance.currentUser?.uid;
      final collectionRef = getcollection();

      final docRef = collectionRef.doc(userID);

      final doc = await docRef.get();
      final data = doc.data();
      if (data == null){
        return [];
      }

      return data.favoriteMovies;
    } catch (error) {
      return [];
    }
  }
}
