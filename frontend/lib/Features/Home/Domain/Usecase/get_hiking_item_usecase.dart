import 'package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart';
import 'package:frontend/Features/Home/Domain/Repository/home_repo.dart';

class GetHikingItemUsecase {
  final HomeRepo homeRepo;
  GetHikingItemUsecase({required this.homeRepo});

  Future<List<HikingCardItem>?> call() async {
    var result = await homeRepo.getHomePageDetails();
    if (result != null) {
      print("hitted use cae");
      print(result.length);
      return result;
    }
  }
}
