part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegistrationSucess extends AuthState {}

class RegistrationFailure extends AuthState {}

class LoginSucess extends AuthState {}

class LoginFailure extends AuthState {}
