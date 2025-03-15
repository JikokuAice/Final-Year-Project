import 'package:frontend/Features/Admin/Domain/Repo/admin_repo.dart';
import 'package:frontend/Features/Admin/Domain/entity/create_trail_with_map.dart';

class CreateTrailWithMapUsecase {
  final AdminRepo adminRepo;
  CreateTrailWithMapUsecase({required this.adminRepo});

  Future<String?> call(CreateTrailWithMap trailWithMapEntity) async {
    var result = adminRepo.createTrailWithMap(trailWithMapEntity);
    print("hitting hau createTrailWithMap");
    return result;
  }
}
