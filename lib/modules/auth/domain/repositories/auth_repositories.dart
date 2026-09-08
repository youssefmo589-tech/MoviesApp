import '../entity/user_entity.dart';

abstract class AuthRepositories {
  Future<UserEntity> login(String email, String password);

  Future<UserEntity> register(
      String name, String email, String password, String phone, int avatarIndex);

  Future<void> forgetPassword(String email);
}