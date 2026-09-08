import 'package:movieapp/modules/auth/domain/entity/user_entity.dart';

import '../repositories/auth_repositories.dart';

class LoginUseCase {
  final AuthRepositories _authRepositories;
  LoginUseCase(this._authRepositories);

  Future<UserEntity> call(String email, String password) {
    return _authRepositories.login(email, password);
  }
}
