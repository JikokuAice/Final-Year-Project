import 'package:frontend/Features/Admin/Data/Model/create_trail_with_map_model.dart';
import 'package:frontend/Features/Admin/Data/Model/update_trail_with_map_model.dart';
import 'package:frontend/Features/Admin/Data/admin_Data_Source/admin_data_source_imp.dart';
import 'package:frontend/Features/Admin/Domain/Repo/admin_repo.dart';
import 'package:frontend/Features/Admin/Domain/entity/create_trail_with_map.dart';
import 'package:frontend/Features/Admin/Domain/entity/getTrailWithMapEntity.dart';
import 'package:frontend/Features/Admin/Domain/entity/update_trail_with_map_entity.dart';

class AdminRepository extends AdminRepo {
  final AdminDataSource adminDataSource;

  AdminRepository({required this.adminDataSource});

  @override
  Future<String?> createTrailWithMap(CreateTrailWithMap trailAndMap) async {
    CreateTrailWithMapModel model = CreateTrailWithMapModel(
        name: trailAndMap.name,
        images: trailAndMap.images,
        description: trailAndMap.description,
        trailType: trailAndMap.trailType,
        startLatlang: trailAndMap.startLatlang,
        destinationLatlang: trailAndMap.destinationLatlang,
        altitude: trailAndMap.altitude,
        distance: trailAndMap.distance,
        averageTime: trailAndMap.averageTime,
        polypoints: trailAndMap.polypoints,
        difficulty: trailAndMap.diffculty,
      mapName: trailAndMap.mapName,
        location: trailAndMap.location);
    var result = await adminDataSource.createTrailWithMap(model);
    return result;
  }

  @override
  Future<String?> getElevation(String latitude, String longitude) async {
    var result = await adminDataSource.getElevation(latitude, longitude);
    return result;
  }

  @override
  Future<String?> deleteTrailWithMap(int id) async {
    var result = await adminDataSource.deleteTrailWithMap(id);
    return result;
  }

  @override
  Future<GetTrialWithMapEntity> getSpecificTrail(int id) async {
    //data = GetTrialWithMapModel?
    var data = await adminDataSource.getSpecificTrail(id);
    var result = GetTrialWithMapEntity(
        id: data!.id,
        name: data.name,
        images: data.images,
        description: data.description,
        trailType: data.trailType,
        rating: data.rating,
        location: data.location,
        difficulty: data.difficulty,
        mapId: data.mapId,
        mapName: data.mapName,
        destinationLatlang: data.destinationLatlang,
        startLatlang: data.startLatlang,
        altitude: data.altitude,
        distance: data.distance,
        averageTime: data.averageTime,
        polypoints: data.polypoints);
    return result;
  }

  @override
  Future<String?> updateTrailOrMap(
      UpdateTrailWithMapEntity updateTrailEntity) async {
    UpdateTrailWithMapModel updatedModel = UpdateTrailWithMapModel(
        id: updateTrailEntity.id,
        name: updateTrailEntity.name,
        description: updateTrailEntity.description,
        diffculty: updateTrailEntity.diffculty,
        trailType: updateTrailEntity.trailType,
        images: updateTrailEntity.images,
        rating: updateTrailEntity.rating,
        location: updateTrailEntity.location,
        mapAltitude: updateTrailEntity.mapAltitude,
        mapId: updateTrailEntity.mapId,
        mapName: updateTrailEntity.mapName,
        mapDestinationLatlang: updateTrailEntity.mapDestinationLatlang,
        mapAverageTime: updateTrailEntity.mapAverageTime,
        mapDistance: updateTrailEntity.mapDistance,
        mapPolypoints: updateTrailEntity.mapPolypoints,
        mapStartLatLang: updateTrailEntity.mapStartLatLang);
    var data = await adminDataSource.updateTrailOrMap(updatedModel);
    return data;
  }
}
