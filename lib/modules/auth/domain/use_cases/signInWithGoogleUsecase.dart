import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repositories.dart';

class SignInWithGoogleUseCase {
  final AuthRepositories _authRepositories;

  SignInWithGoogleUseCase(this._authRepositories);

  Future<UserCredential?> call() async {
    return _authRepositories.signinwithgoogle();
  }
}
