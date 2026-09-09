import 'package:flutter_bloc/flutter_bloc.dart';

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

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required ForgetPasswordUseCase forgetPasswordUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _forgetPasswordUseCase = forgetPasswordUseCase,
        super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<ForgetPasswordRequested>(_onForgetPasswordRequested);
  }

  factory AuthBloc.withDefaultDependencies() {
    final AuthRepositories repository =
    AuthRepositoriesImp(FirebaseAuthDataSource());
    return AuthBloc(
      loginUseCase: LoginUseCase(repository),
      registerUseCase: RegisterUseCase(repository),
      forgetPasswordUseCase: ForgetPasswordUseCase(repository),
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

  String _cleanMessage(Object error) =>
      error.toString().replaceFirst('Exception: ', '');
}