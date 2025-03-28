import 'package:frontend/Features/Travel_Route/Data/Data_Source/travel_data_source_imp.dart';
import 'package:frontend/Features/Travel_Route/Data/Model/UserActivity_Model.dart';
import 'package:frontend/Features/Travel_Route/Domain/Entity/Map_Entity.dart';
import 'package:frontend/Features/Travel_Route/Domain/Entity/UserActivity_Entity.dart';
import 'package:frontend/Features/Travel_Route/Domain/Repo/Travel_Repo.dart';

// ignore: non_constant_identifier_names
class TravelRepositoryImp extends TravelRepo {
  final TravelDataSource dataSource;

  TravelRepositoryImp({required this.dataSource});

  @override
  Future<MapEntity?> fetchMap(int id) async {
    var result = await dataSource.fetchMap(id);
    var entity = MapEntity(
        id: result!.id,
        mapName: result.mapName,
        destinationLatlang: result.destinationLatlang,
        startLatlang: result.startLatlang,
        altitude: result.altitude,
        distance: result.distance,
        polypoints: result.polypoints);
    return entity;
  }

  @override
  Future<bool> addUserActivity(UseractivityEntity entity) async {
    var model = UseractivityModel(
        timeElapsed: entity.timeElapsed,
        trailName: entity.trailName,
        avgSpeed: entity.avgSpeed,
        distanceCovered: entity.distanceCovered,
        userId: entity.userId,
        trailId: entity.trailId);
    var result = await dataSource.addUserActivity(model);
    return result;
  }
}
