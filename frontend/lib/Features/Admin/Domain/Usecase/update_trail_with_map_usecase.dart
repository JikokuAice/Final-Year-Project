import 'package:frontend/Features/Admin/Domain/Repo/admin_repo.dart';
import 'package:frontend/Features/Admin/Domain/entity/update_trail_with_map_entity.dart';

class UpdateTrailWithMapUsecase {
  final AdminRepo adminRepo;
  UpdateTrailWithMapUsecase({required this.adminRepo});

  Future<String?> call(UpdateTrailWithMapEntity updateTrailEntity) async {
    var result = await adminRepo.updateTrailOrMap(updateTrailEntity);
    return result;
  }
}
