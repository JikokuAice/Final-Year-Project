class UseractivityModel {
//  "trailName": "string",
//     "distanceCovered": "string",
//     "avgSpeed": "string",
//     "timeElapsed": "string",
//     "activityDate": "2025-03-25T11:05:50.046Z",
//     "trailId": 0,
//     "userId": 0

  String trailName;
  String distanceCovered;
  String avgSpeed;
  String timeElapsed;
  int trailId;
  DateTime? activityDate;
  int userId;

  UseractivityModel(
      {required this.timeElapsed,
      required this.trailName,
      required this.avgSpeed,
      required this.distanceCovered,
      required this.userId,
      required this.trailId,
      this.activityDate});

  Map<String, dynamic> toJson(UseractivityModel model) {
    return {
      "trailName": model.trailName,
      "distanceCovered": model.distanceCovered,
      "avgSpeed": model.avgSpeed,
      "timeElapsed": model.timeElapsed,
      "trailId": model.trailId,
      "userId": model.userId,
      "activityDate": DateTime.now().toUtc(),
    };
  }
}
