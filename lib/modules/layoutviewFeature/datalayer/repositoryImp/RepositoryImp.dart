import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repository/LayoutviewRepositories.dart';
import '../datasources/FirebaseDataSource.dart';

class RepositoryImp implements LayoutRepositories {
  @override
  Future<bool> EditImageProfile(String image) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseDataSource.editprofileimage(image, userID);
  }

  @override
  Future<bool> EditNameProfile(String name) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseDataSource.editprofilename(name, userID);
  }

  @override
  Future<bool> EditphoneProfile(String phone) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseDataSource.editprofilephone(phone, userID);
  }
}