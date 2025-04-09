import 'package:dio/dio.dart';
import 'package:frontend/Features/Profile/Data/Model/user_activity_model.dart';
import 'package:frontend/contrant/Network_Route.dart';
import 'package:logger/logger.dart';

abstract class ProfileDataSource {
  Future<List<UserActivityModel?>> fetchUserActivity(String token);
}

class ProfileDataSourceImp extends ProfileDataSource {
  final Dio _dio;
  final Logger _logger;

  ProfileDataSourceImp(this._dio, this._logger);

  @override
  Future<List<UserActivityModel?>> fetchUserActivity(String token) async {
    _logger.e(token);
    List<UserActivityModel> list = [];
    var response = await _dio.get(
      "$localHostUrl/GetUserActivity",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
    _logger.i(response.data);

    for (var i in response.data) {
      list.add(UserActivityModel.fromJson(i));
    }
    _logger.i(list);

    return list;
  }
}
