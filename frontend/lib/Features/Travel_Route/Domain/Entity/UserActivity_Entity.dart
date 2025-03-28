class UseractivityEntity {
  String trailName;
  String distanceCovered;
  String avgSpeed;
  String timeElapsed;
  int trailId;
  DateTime? activityDate;
  int userId;

  UseractivityEntity(
      {required this.timeElapsed,
      required this.trailName,
      required this.avgSpeed,
      required this.distanceCovered,
      required this.userId,
      required this.trailId,
      this.activityDate});
}
