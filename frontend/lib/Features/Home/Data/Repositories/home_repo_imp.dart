import 'package:frontend/Features/Home/Data/Data_Source/remote_data_source.dart';
import 'package:frontend/Features/Home/Data/model/AddCommentModel.dart';
import 'package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart';
import 'package:frontend/Features/Home/Domain/Entity/add_comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Entity/comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Entity/trail_detail_entity.dart';
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

  @override
  Future<TrailDetailEntity> getTrailDetail(int trailId) async {
    var trailDetailModel = await remoteDataSource.getTrailDetail(trailId);
    var trailDetEntity = TrailDetailEntity(
        images: trailDetailModel!.images,
        name: trailDetailModel.name,
        location: trailDetailModel.location,
        difficulty: trailDetailModel.difficulty,
        distance: trailDetailModel.distance,
        trailType: trailDetailModel.trailType,
        altitude: trailDetailModel.altitude,
        averageTime: trailDetailModel.averageTime,
        description: trailDetailModel.description);
    return trailDetEntity;
  }

  @override
  Future<List<CommentEntity>?> getTrailComment(int trailId) async {
    var resultmodelList = await remoteDataSource.getTrailComment(trailId);
    if (resultmodelList == null) {
      return null;
    }
    List<CommentEntity> resultEntityList = [];
    for (var element in resultmodelList) {
      CommentEntity comment = CommentEntity(
          id: element.id,
          image: element.image,
          likes: element.likes,
          text: element.text,
          userId: element.userId,
          userName: element.userName);
      resultEntityList.add(comment);
    }
    return resultEntityList;
  }

  @override
  Future<bool> deleteUserComment(int commentId, int userId) async {
    var result = await remoteDataSource.deleteUserComment(commentId, userId);
    return result;
  }

  @override
  Future<bool> addComment(AddCommentEntity addCommentEntity) async {
    var commentModel = AddCommentModel(
        commentText: addCommentEntity.commentText,
        trailId: addCommentEntity.trailId,
        userId: addCommentEntity.userId);
    var result = await remoteDataSource.addComment(commentModel);
    return result;
  }
}
