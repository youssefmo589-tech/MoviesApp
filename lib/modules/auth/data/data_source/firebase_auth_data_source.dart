import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_data_source_interface.dart';

class FirebaseAuthDataSource implements AuthDataSourceInterface {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<User> login(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'Could not sign in with those credentials.',
      );
    }
    return user;
  }

  @override
  Future<User> register(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'Could not create the account.',
      );
    }
    return user;
  }

  @override
  Future<void> forgetPassword(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<UserCredential?> signinwithgoogle() async {
    await GoogleSignIn().signOut();

    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

    if (googleuser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleauth =
        await googleuser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleauth.accessToken,
      idToken: googleauth.idToken,
    );

    final result = await FirebaseAuth.instance.signInWithCredential(credential);

    return result;
  }
}
