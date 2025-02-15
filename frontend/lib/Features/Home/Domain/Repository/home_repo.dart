import 'package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart';

abstract class HomeRepo {
  Future<List<HikingCardItem>?> getHomePageDetails();
}
