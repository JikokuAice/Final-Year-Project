import 'package:frontend/Features/Home/Domain/Entity/trail_detail_entity.dart';
import 'package:frontend/Features/Home/Domain/Repository/home_repo.dart';

class GetTrailDetailUsecase {
  final HomeRepo homeRepo;
  GetTrailDetailUsecase({required this.homeRepo});

  Future<TrailDetailEntity> call(int trailId) async {
    var result = await homeRepo.getTrailDetail(trailId);
    return result;
  }
}
