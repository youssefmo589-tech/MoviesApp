import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entity/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccessSignInWithGoogle extends AuthState {
  final String message;

  AuthSuccessSignInWithGoogle(this.message);

  List<Object?> get props => [message];
}

class AuthNewGoogleUser extends AuthState {
  UserCredential credential;

  AuthNewGoogleUser(this.credential);

  List<Object?> get props => [credential];
}

class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class ForgetPasswordEmailSent extends AuthState {
  final String email;

  const ForgetPasswordEmailSent(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}