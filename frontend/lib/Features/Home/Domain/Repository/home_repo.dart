import 'package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart';
import 'package:frontend/Features/Home/Domain/Entity/add_comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Entity/comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Entity/trail_detail_entity.dart';

abstract class HomeRepo {
  Future<List<HikingCardItem>?> getHomePageDetails();
  Future<TrailDetailEntity> getTrailDetail(int trailId);
  Future<List<CommentEntity>?> getTrailComment(int trailId);
  Future<bool> deleteUserComment(int commentId, int userId);
  Future<bool> addComment(AddCommentEntity addCommentEntity);
}
