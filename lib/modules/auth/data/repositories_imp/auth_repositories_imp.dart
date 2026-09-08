import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/FirebaseCloudService/FirestoreCloudService.dart';
import '../../../layoutviewFeature/datalayer/Models/UserModel.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../data_source/auth_data_source_interface.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final AuthDataSourceInterface _dataSource;

  AuthRepositoriesImp(this._dataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final user = await _dataSource.login(email, password);
      return UserEntity(
        uid: user.uid,
        email: user.email ?? email,
        name: user.displayName ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  @override
  Future<UserEntity> register(
      String name, String email, String password, String phone) async {
    try {
      final user = await _dataSource.register(email, password);

      // Persist the profile alongside the auth account.
      await FirestoreCloudService.createuser(
        UserModel(userID: user.uid, name: name, phone: phone, image: ''),
      );

      return UserEntity(uid: user.uid, email: user.email ?? email, name: name, phone: phone);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await _dataSource.forgetPassword(email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'That email address looks invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with that email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account already exists with that email.';
      case 'weak-password':
        return 'Please choose a stronger password (6+ characters).';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return e.message ?? 'Something went wrong. Please try again.';
    }
  }
}