import 'package:frontend/Features/Travel_Route/Domain/Entity/Map_Entity.dart';
import 'package:frontend/Features/Travel_Route/Domain/Entity/UserActivity_Entity.dart';

abstract class TravelRepo {
  Future<MapEntity?> fetchMap(int id);
  Future<bool> addUserActivity(UseractivityEntity entity);
}
