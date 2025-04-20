import 'package:dio/dio.dart';
import 'package:frontend/Features/Travel_Route/Data/Model/Map_Model.dart';
import 'package:frontend/Features/Travel_Route/Data/Model/UserActivity_Model.dart';
import 'package:frontend/contrant/Network_Route.dart';
import 'package:logger/logger.dart';

abstract class TravelDataSource {
  Future<MapModel?> fetchMap(int id);
  Future<bool> addUserActivity(UseractivityModel model);
}

class TravelDataSourceImp extends TravelDataSource {
  final Dio dio;
  final Logger log;

  TravelDataSourceImp(this.dio, this.log);
  @override
  Future<MapModel?> fetchMap(int id) async {
    var result = await dio.get("$localHostUrl$getSpecificMap$id");
    log.e(result.data);
    var model = MapModel.toJson(result.data);
    log.i(model.destinationLatlang);
    log.i(model.startLatlang);
    return model;
  }

  @override
  Future<bool> addUserActivity(UseractivityModel model) async {
    var result = await dio.post(
      "$localHostUrl$addActivity",
      data: {
        "userActivitiesDtos": {
          "trailName": model.trailName,
          "distanceCovered": model.distanceCovered,
          "avgSpeed": model.avgSpeed,
          "timeElapsed": model.timeElapsed,
          "activityDate": "2025-03-28T06:05:59.027Z",
          "trailId": model.trailId,
          "userId": model.userId
        }
      },
    );
    var resultStatus = result.statusCode;
    if (resultStatus != 200) {
      return false;
    }
    return true;
  }
}
