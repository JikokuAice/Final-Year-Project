import 'package:dio/dio.dart';
import 'package:frontend/Features/Authentication/Data/model/login_model.dart';
import 'package:frontend/Features/Authentication/Data/model/register_model.dart';
import 'package:frontend/Features/Authentication/Data/model/token_model.dart';
import 'package:frontend/contrant/Network_Route.dart';
import 'package:logger/logger.dart';

abstract class AuthRemoteDataSource {
  Future<bool> registerUser(RegisterModel register);
  Future<TokenModel?> loginUser(LoginModel login);
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  final Dio dio;
  final Logger log;

  AuthRemoteDataSourceImp(this.dio, this.log);
  @override
  Future<bool> registerUser(RegisterModel register) async {
    Response response;
    try {
      response = await dio.post("$localHostUrl$registerRoute",
          data: register.tojson());
      log.d(response.headers);
      if (response.statusCode == 400 || response.statusCode == 401) {
        return false;
      }
      log.d(response.data);
    } catch (e) {
      log.e(e.toString());
      return false;
    }
    return true;
  }

  @override
  Future<TokenModel?> loginUser(LoginModel login) async {
    Response response;
    try {
      log.e(login);
      response = await dio.post("https://192.168.42.103:5001/Login",
          data: login.tojson());
      log.d(response.data);
      Map<String, dynamic> jsonResponse = response.data;
      log.e(jsonResponse);
      var tokenModel = TokenModel.fromJson(jsonResponse);
      return tokenModel;
    } catch (e) {
      log.e(e.toString());
    }
    return null;
  }
}
