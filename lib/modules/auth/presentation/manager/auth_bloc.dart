import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/auth/domain/use_cases/completeGoogleRegistrationUsecase.dart';
import 'package:movieapp/modules/auth/domain/use_cases/signInWithGoogleUsecase.dart';

import '../../data/data_source/firebase_auth_data_source.dart';
import '../../data/repositories_imp/auth_repositories_imp.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../../domain/use_cases/forget_password_use_case.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  final CompleteGoogleRegistrationUseCase _completeGoogleRegistrationUseCase;
  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required ForgetPasswordUseCase forgetPasswordUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required CompleteGoogleRegistrationUseCase completeGoogleRegistrationUseCase,
  })
      : _signInWithGoogleUseCase = signInWithGoogleUseCase,
        _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _forgetPasswordUseCase = forgetPasswordUseCase,
        _completeGoogleRegistrationUseCase = completeGoogleRegistrationUseCase,
        super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<ForgetPasswordRequested>(_onForgetPasswordRequested);
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
    on<CompleteGoogleRegistrationRequested>(
        _oncompleteGoogleRegistrationRequested);
  }

  factory AuthBloc.withDefaultDependencies() {
    final AuthRepositories repository =
    AuthRepositoriesImp(FirebaseAuthDataSource());
    return AuthBloc(
      loginUseCase: LoginUseCase(repository),
      registerUseCase: RegisterUseCase(repository),
      forgetPasswordUseCase: ForgetPasswordUseCase(repository),
      signInWithGoogleUseCase: SignInWithGoogleUseCase(repository),
      completeGoogleRegistrationUseCase: CompleteGoogleRegistrationUseCase(
          repository),
    );
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _loginUseCase(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(_cleanMessage(e)));
    }
  }

  Future<void> _oncompleteGoogleRegistrationRequested(
      CompleteGoogleRegistrationRequested event, Emitter<AuthState> emit) async
  {
    emit(AuthLoading());
    try {
      final user = await _completeGoogleRegistrationUseCase(
          event.uid, event.name, event.email, event.phone, event.avatarIndex);
      emit(AuthSuccess(user));
    } catch (error) {
      emit(AuthFailure(_cleanMessage(error)));
    }
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _registerUseCase(
        event.name,
        event.email,
        event.password,
        event.phone,
        event.avatarIndex,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(_cleanMessage(e)));
    }
  }

  Future<void> _onForgetPasswordRequested(
      ForgetPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _forgetPasswordUseCase(event.email);
      emit(ForgetPasswordEmailSent(event.email));
    } catch (e) {
      emit(AuthFailure(_cleanMessage(e)));
    }
  }

  Future<void> _onSignInWithGoogleEvent(SignInWithGoogleEvent event,
      Emitter<AuthState> emit,) async {
    emit(AuthLoading());

    try {
      final result = await _signInWithGoogleUseCase();

      if (result == null) {
        emit(AuthFailure("Google sign in cancelled"));
        return;
      }

      final isNewUser =
          result.additionalUserInfo?.isNewUser ?? false;

      print("GOOGLE UID: ${result.user?.uid}");
      print("IS NEW USER: $isNewUser");

      if (isNewUser) {
        emit(AuthNewGoogleUser(result));
      } else {
        emit(AuthSuccessSignInWithGoogle("Login Success"));
      }
    } catch (e) {
      print("GOOGLE BLOC ERROR: $e");
      emit(AuthFailure(_cleanMessage(e)));
    }
  }

  String _cleanMessage(Object error) =>
      error.toString().replaceFirst('Exception: ', '');
}