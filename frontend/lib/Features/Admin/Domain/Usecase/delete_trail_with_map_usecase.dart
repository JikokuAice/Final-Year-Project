import 'package:frontend/Features/Admin/Domain/Repo/admin_repo.dart';

class DeleteTrailWithMapUsecase {
  final AdminRepo adminRepo;
  DeleteTrailWithMapUsecase({required this.adminRepo});

  Future<String?> call(int id) async {
    var result = adminRepo.deleteTrailWithMap(id);
    return result;
  }
}
