import 'package:frontend/Features/Travel_Route/Domain/Entity/UserActivity_Entity.dart';
import 'package:frontend/Features/Travel_Route/Domain/Repo/Travel_Repo.dart';

class AddUserActivityUsecase {
  final TravelRepo repo;

  AddUserActivityUsecase({required this.repo});

  Future<bool> call(UseractivityEntity entity) async {
    var result = await repo.addUserActivity(entity);
    return result;
  }
}
