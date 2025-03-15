import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/Features/Admin/Data/Model/create_trail_with_map_model.dart';
import 'package:frontend/Features/Admin/Data/Model/getTrialWithMapModel.dart';
import 'package:frontend/Features/Admin/Data/Model/update_trail_with_map_model.dart';
import 'package:frontend/contrant/Network_Route.dart';
import 'package:logger/logger.dart';

abstract class AdminDataSource {
  Future<String?> createTrailWithMap(CreateTrailWithMapModel trailAndMap);
  Future<String?> getElevation(String latitude, String longitude);
  Future<String?> deleteTrailWithMap(int id);
  Future<GetTrialWithMapModel?> getSpecificTrail(int id);
  Future<String?> updateTrailOrMap(UpdateTrailWithMapModel updateTrailModel);
}

class AdminDataSourceImp extends AdminDataSource {
  final Dio dio;
  final Logger log;

  AdminDataSourceImp(this.dio, this.log);

  @override
  Future<String?> createTrailWithMap(
      CreateTrailWithMapModel trailAndMap) async {
    try {
      List<MultipartFile> formDatas = [];

      //  for (int i = 0; i < trailAndMap.images.length; i++) {
      //   var extension = trailAndMap.images[i].path.split(".").last;

      //   formDatas.add(await MultipartFile.fromFile(trailAndMap.images[i].path,
      //      filename: '${trailAndMap.name}_$i.$extension'));
      //  }
      var trailAndMapJson = trailAndMap.toJson();
      // FormData formData = FormData.fromMap({'file': formDatas});

      // log.f(trailAndMapJson);
      var result =
          await dio.post('$localHostUrl/AddTrail', data: trailAndMapJson);
      // log.e(result.data);
      // trailAndMap.images= result.data;
      return result.statusMessage;
    } catch (e) {
      log.e(e);
    }
  }

  @override
  Future<String?> getElevation(String latitude, String longitude) async {
    try {
      if (latitude.isEmpty || longitude.isEmpty) {
        return null;
      }
      log.e("man");
      var result = await dio.get(
          "https://maps.googleapis.com/maps/api/elevation/json?locations=$latitude,$longitude&key=AIzaSyAfVD-fFk1aa4yy4YFesrLIXhxwNHhQtxU");
      var elevation = result.data["results"][0]["elevation"];
      log.e(elevation);
      elevation = elevation / 1000;
      return elevation.toStringAsFixed(1);
    } catch (e) {
      log.e(e);
    }
  }

  @override
  Future<String?> deleteTrailWithMap(int Id) async {
    try {
      var result = await dio.delete("$localHostUrl/DeleteTrail/$Id");
      log.f(result.statusMessage);
    } catch (e) {
      log.d(e.toString());
    }
    return Future.delayed(Duration.zero, () => "200");
  }

  @override
  Future<GetTrialWithMapModel?> getSpecificTrail(int id) async {
    try {
      var result = await dio.get('$localHostUrl$getTrailWithId$id');
      log.f(result.data);
      var data = GetTrialWithMapModel.fromJson(result.data);
      return data;
    } catch (e) {
      log.e(e.toString());
    }
  }

  @override
  Future<String?> updateTrailOrMap(
      UpdateTrailWithMapModel updateTrailModel) async {
    try {
      var data = UpdateTrailWithMapModel().toJson(updateTrailModel);
      var result = await dio.put('$localHostUrl$updateTrail', data: data);
      log.f(result.data);
      return result.statusMessage;
    } catch (e) {
      log.e(e.toString());
    }
  }
}
