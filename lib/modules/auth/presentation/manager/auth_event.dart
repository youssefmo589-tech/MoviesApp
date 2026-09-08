import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final int avatarIndex;


  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.phone, required this.avatarIndex,
  });

  @override
  List<Object?> get props => [name, email, password, phone, avatarIndex];
}

class ForgetPasswordRequested extends AuthEvent {
  final String email;

  const ForgetPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}