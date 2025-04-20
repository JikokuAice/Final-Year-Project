class CommentEntity {
  int id;
  String text;
  int likes;
  int userId;
  String userName;
  String image;

  CommentEntity(
      {required this.id,
      required this.image,
      required this.likes,
      required this.text,
      required this.userId,
      required this.userName});
}
