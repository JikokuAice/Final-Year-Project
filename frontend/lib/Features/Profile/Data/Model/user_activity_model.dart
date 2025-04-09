class UserActivityModel {
// "id": 2,
//         "trailName": "near home",
//         "distanceCovered": "0.0",
//         "avgSpeed": "0.0",
//         "timeElapsed": "0",
//         "activityDate": "2025-03-28T06:05:59.027",
//         "trailId": 1070,
//         "trail": {
//             "id": 1070,
//             "name": "near home",
//             "images": [
//                 "/data/user/0/com.example.frontend/cache/ea011ab2-8305-4f0b-8997-8bd6960bc289/1000000021.jpg"
//             ],
//             "description": "hdns",
//             "trailType": "Out-and-Back Trail",
//             "location": "hdhs",
//             "rating": 0,
//             "difficulty": "Beginner",
//             "maps": null,
//             "userActivites": null
//         },
//         "userId": 14,
//         "user": null

  String trailName;
  String distanceCovered;
  String avgSpeed;
  String timeElapsed;
  String activityDate;
  String images;
  String location;
  String difficulty;
  String trailType;

  UserActivityModel(
      {required this.trailName,
      required this.distanceCovered,
      required this.avgSpeed,
      required this.timeElapsed,
      required this.activityDate,
      required this.difficulty,
      required this.images,
      required this.location,
      required this.trailType});

  factory UserActivityModel.fromJson(Map<String, dynamic> json) {
    return UserActivityModel(
        trailName: json['trailName'],
        distanceCovered: json["distanceCovered"],
        avgSpeed: json["avgSpeed"],
        timeElapsed: json["timeElapsed"],
        activityDate: json["activityDate"].toString(),
        difficulty: json["trail"]["difficulty"],
        images: json["trail"]["images"][0],
        location: json["trail"]["location"],
        trailType: json["trail"]["trailType"]);
  }
}
