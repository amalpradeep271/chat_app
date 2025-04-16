import 'dart:developer';

import 'package:chat_app/feature/auth/domain/usecase/login_usecase.dart';
import 'package:chat_app/feature/auth/domain/usecase/register_usecase.dart';
import 'package:chat_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:chat_app/feature/auth/presentation/bloc/auth_state.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;
  final _storage = FlutterSecureStorage();
  AuthBloc({required this.registerUsecase, required this.loginUsecase})
    : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await registerUsecase.call(
        event.username,
        event.email,
        event.password,
      );
      emit(AuthSuccess(message: "Registration successfull"));
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(error: "Registration Failed"));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUsecase.call(event.email, event.password);
      await _storage.write(key: 'token', value: user.token);
      await _storage.write(key: 'userId', value: user.id);

      log('token:${user.token}');
      emit(AuthSuccess(message: "Login successfull"));
    } catch (e) {
      emit(AuthFailure(error: "Login Failed"));
    }
  }
}
