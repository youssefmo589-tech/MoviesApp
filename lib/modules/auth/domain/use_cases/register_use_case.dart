import 'package:movieapp/modules/auth/domain/entity/user_entity.dart';
import '../repositories/auth_repositories.dart';

class RegisterUseCase {
  final AuthRepositories _authRepositories;
  RegisterUseCase(this._authRepositories);

  Future<UserEntity> call(
    String name,
    String email,
    String password,
    String phone,
    int avatarIndex,
  ) async {
    return await _authRepositories.register(
      name,
      email,
      password,
      phone,
      avatarIndex,
    );
  }
}
