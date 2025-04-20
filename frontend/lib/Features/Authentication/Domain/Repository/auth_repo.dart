import 'package:frontend/Features/Authentication/Domain/Entities/Register.dart';
import 'package:frontend/Features/Authentication/Domain/Entities/Token.dart';
import 'package:frontend/Features/Authentication/Domain/Entities/login.dart';

abstract class AuthRepo {
  Future<bool> registerUser(Register register);
  Future<AuthToken?> loginUser(Login login);

}
