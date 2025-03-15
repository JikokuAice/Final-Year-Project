import 'package:frontend/Features/Admin/Domain/entity/create_trail_with_map.dart';
import 'package:frontend/Features/Admin/Domain/entity/getTrailWithMapEntity.dart';
import 'package:frontend/Features/Admin/Domain/entity/update_trail_with_map_entity.dart';

abstract class AdminRepo {
  Future<String?> createTrailWithMap(CreateTrailWithMap trailAndMap);
  Future<String?> getElevation(String latitude, String longitude);
  Future<String?> deleteTrailWithMap(int id);
  Future<GetTrialWithMapEntity> getSpecificTrail(int id);
  Future<String?> updateTrailOrMap(UpdateTrailWithMapEntity updateTrailEntity);
}
