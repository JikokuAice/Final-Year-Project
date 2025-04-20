//  "id": 2,
//     "commentText": "Updated hai",
//     "likes": 0,
//     "userId": 15,
//     "user": {
//       "name": "dyam",
//       "image": "empty pp"

class CommentModel {
  int id;
  String text;
  int likes;
  int userId;
  String userName;
  String image;

  CommentModel(
      {required this.id,
      required this.image,
      required this.likes,
      required this.text,
      required this.userId,
      required this.userName});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json["id"],
        image: json["user"]["image"] ?? "",
        likes: json["likes"],
        text: json["commentText"],
        userId: json["userId"],
        userName: json["user"]["name"]);
  }
}
