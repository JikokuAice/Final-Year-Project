import 'package:frontend/Features/Authentication/Data/data_source/auth_remote_data_source.dart';
import 'package:frontend/Features/Authentication/Data/model/login_model.dart';
import 'package:frontend/Features/Authentication/Data/model/register_model.dart';
import 'package:frontend/Features/Authentication/Domain/Entities/Register.dart';
import 'package:frontend/Features/Authentication/Domain/Entities/Token.dart';
import 'package:frontend/Features/Authentication/Domain/Repository/auth_repo.dart';

import '../../Domain/Entities/login.dart';

class AuthRepoImp extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImp({required this.authRemoteDataSource});

  @override
  Future<bool> registerUser(Register register) {
    final model = RegisterModel(
        name: register.name,
        email: register.email,
        password: register.password,
        image: register.image);
    return authRemoteDataSource.registerUser(model);
  }

  @override
  Future<AuthToken?> loginUser(Login login) async {
    final model = LoginModel(email: login.email, password: login.password);
    var tokenModel = await authRemoteDataSource.loginUser(model);
    if (tokenModel == null) {
      return null;
    }

    final authToken = AuthToken(
        acessToken: tokenModel.acessToken,
        refreshToken: tokenModel.acessToken,
        role: tokenModel.role);
    return authToken;
  }
}
