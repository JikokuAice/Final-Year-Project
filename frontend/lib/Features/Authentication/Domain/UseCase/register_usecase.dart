import 'dart:math';

import 'package:frontend/Features/Authentication/Domain/Entities/Register.dart';
import 'package:frontend/Features/Authentication/Domain/Repository/auth_repo.dart';

class RegisterUsecase {
  final AuthRepo authRepo;
  RegisterUsecase({required this.authRepo});

  Future<bool> call(Register user) async {
    print("hitted register Usecase");
    return await authRepo.registerUser(user);
  }
}
