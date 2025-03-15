import 'package:frontend/Features/Home/Data/Data_Source/remote_data_source.dart';
import 'package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart';
import 'package:frontend/Features/Home/Domain/Repository/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final RemoteDataSource remoteDataSource;
  HomeRepoImp({required this.remoteDataSource});

  @override
  Future<List<HikingCardItem>?> getHomePageDetails() async {
    var result = await remoteDataSource.getHomePageDetails();
    var convertedResult = result
        ?.map((e) => HikingCardItem(
            id: e.id,
            name: e.name,
            length: e.length,
            rating: e.rating,
            difficulty: e.difficulty,
            images: e.images))
        .toList();
    return convertedResult;
  }
}
