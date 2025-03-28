import 'package:frontend/Features/Travel_Route/Domain/Entity/Map_Entity.dart';
import 'package:frontend/Features/Travel_Route/Domain/Repo/Travel_Repo.dart';

class FetchMapUsecase {
  final TravelRepo repo;

  FetchMapUsecase({required this.repo});

  Future<MapEntity?> call(int id) async {
    var result = await repo.fetchMap(id);
    return result;
  }
}
