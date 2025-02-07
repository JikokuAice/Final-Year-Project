import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Features/Authentication/Domain/Entities/Register.dart';
import 'package:frontend/Features/Authentication/Domain/Entities/login.dart';
import 'package:frontend/Features/Authentication/Domain/UseCase/login_usecase.dart';
import 'package:frontend/Features/Authentication/Domain/UseCase/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;

  AuthBloc({required this.registerUsecase, required this.loginUsecase})
      : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      try {
        var data = await registerUsecase.call(event.register);

        if (data) {
          emit(RegistrationSucess());
        } else {
          emit(RegistrationFailure());
        }
      } catch (e) {
        emit(RegistrationFailure());
        print("falure emitted");
      }
    });

    on<LoginEvent>((event, emit) async {
      try {
        var data = await loginUsecase.call(event.login);
        if (data != null) {
          emit(LoginSucess());
        } else {
          emit(LoginFailure());
        }
      } catch (e) {
        emit(LoginFailure());
      }
    });
  }
}
