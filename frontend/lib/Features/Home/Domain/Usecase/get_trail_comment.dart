import 'package:frontend/Features/Home/Domain/Entity/comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Repository/home_repo.dart';

class GetTrailCommentUsecase {
  final HomeRepo repo;
  GetTrailCommentUsecase({required this.repo});

  Future<List<CommentEntity>?> call(int trailId) async {
    var result = await repo.getTrailComment(trailId);
    return result;
  }
}
