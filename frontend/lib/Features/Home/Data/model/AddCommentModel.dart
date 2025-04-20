class AddCommentModel {
  final String commentText;
  final int userId;
  final int trailId;

  const AddCommentModel(
      {required this.commentText, required this.trailId, required this.userId});
}
