class AddCommentEntity {
  final String commentText;
  final int userId;

  final int trailId;

  const AddCommentEntity(
      {required this.commentText, required this.trailId, required this.userId});
}
