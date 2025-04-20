import 'package:frontend/Features/Home/Domain/Repository/home_repo.dart';

class DeleteUserCommentUsecase {
  final HomeRepo repo;

  const DeleteUserCommentUsecase({required this.repo});

  Future<bool> call(int commentId, int userId) async {
    var result = await repo.deleteUserComment(commentId, userId);
    return result;
  }
}
