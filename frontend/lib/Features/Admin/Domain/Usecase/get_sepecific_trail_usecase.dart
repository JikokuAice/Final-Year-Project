import 'package:frontend/Features/Admin/Domain/Repo/admin_repo.dart';
import 'package:frontend/Features/Admin/Domain/entity/getTrailWithMapEntity.dart';

class GetSepecificTrailUsecase {
  final AdminRepo adminRepo;
  GetSepecificTrailUsecase({required this.adminRepo});

  Future<GetTrialWithMapEntity> call(int id) async {
    var result = await adminRepo.getSpecificTrail(id);
    return result;
  }
}
