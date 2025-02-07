part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final Register register;

  RegisterEvent({required this.register});
}

class LoginEvent extends AuthEvent {
  final Login login;

  LoginEvent({required this.login});
}
