class UserActivityEntity {
  String trailName;
  String distanceCovered;
  String avgSpeed;
  String timeElapsed;
  String activityDate;
  String images;
  String location;
  String difficulty;
  String trailType;

  UserActivityEntity(
      {required this.trailName,
      required this.distanceCovered,
      required this.avgSpeed,
      required this.timeElapsed,
      required this.activityDate,
      required this.difficulty,
      required this.images,
      required this.location,
      required this.trailType});
}
