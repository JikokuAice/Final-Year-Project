import 'package:dio/dio.dart';
import 'package:frontend/Features/Home/Data/model/Hiking_Card_Model.dart';
import 'package:logger/logger.dart';

abstract class RemoteDataSource {
  Future<List<HikingCardModel>?> getHomePageDetails();
}

class RemoteDataSourceImp extends RemoteDataSource {
  final Dio dio;
  final Logger log;

  RemoteDataSourceImp(this.dio, this.log);

  @override
  Future<List<HikingCardModel>?> getHomePageDetails() async {
    var result = await dio
        .get("https://192.168.100.7:5001/api/User/GetAllTrial")
        .timeout(const Duration(seconds: 2));
    log.e(result.data);
    log.e(result);
    List<dynamic> jsonList = result.data; // Raw list from API
    return jsonList.map((json) => HikingCardModel.fromJson(json)).toList();
  }
}
