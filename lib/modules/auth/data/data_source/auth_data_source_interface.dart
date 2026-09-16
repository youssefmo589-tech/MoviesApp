import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSourceInterface {
  Future<User> login(String email, String password);

  Future<User> register(String email, String password);

  Future<void> forgetPassword(String email);

  User? get currentUser;
}