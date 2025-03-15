import 'package:frontend/Features/Admin/Domain/Repo/admin_repo.dart';

class RetriveElevationUsecase {
  final AdminRepo adminRepo;

  RetriveElevationUsecase({required this.adminRepo});

  Future<String?> call(String latitude, String longitude) async {
    var result = await adminRepo.getElevation(latitude, longitude);
    print("hitting hau");
    return result;
  }
}
