import 'package:frontend/Features/Home/Domain/Entity/add_comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Entity/comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Repository/home_repo.dart';

class AddUserCommentUsecase {
  final HomeRepo homeRepo;

  const AddUserCommentUsecase({required this.homeRepo});

  Future<bool> call(AddCommentEntity entity) async {
    var result = await homeRepo.addComment(entity);
    return result;
  }
}
