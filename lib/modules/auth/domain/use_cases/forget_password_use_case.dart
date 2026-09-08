import '../repositories/auth_repositories.dart';

class ForgetPasswordUseCase {
  final AuthRepositories _authRepositories;
  ForgetPasswordUseCase(this._authRepositories);

  Future<void> call(String email) {
    return _authRepositories.forgetPassword(email);
  }
}