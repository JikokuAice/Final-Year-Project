import 'package:frontend/App/Dependency_Injection/dependency_injection.dart';
import 'package:frontend/Features/Authentication/Domain/Entities/Token.dart';
import 'package:frontend/Features/Authentication/Domain/Entities/login.dart';
import 'package:frontend/Features/Authentication/Domain/Repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUsecase {
  final AuthRepo authRepo;
  LoginUsecase({required this.authRepo});

  Future<AuthToken?> call(Login login) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await authRepo.loginUser(login);
    prefs.setString("acessToken", response!.acessToken);
    prefs.setString("refreshToken", response.refreshToken);
    prefs.setString("role", response.role);
    return response;
  }
}
