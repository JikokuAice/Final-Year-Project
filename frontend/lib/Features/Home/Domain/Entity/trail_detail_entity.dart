class TrailDetailEntity {
  List<String> images;
  String name;
  String location;
  String difficulty;
  String trailType;
  String averageTime;
  num altitude;
  num distance;
  String description;

  TrailDetailEntity(
      {required this.images,
      required this.name,
      required this.location,
      required this.difficulty,
      required this.distance,
      required this.trailType,
      required this.altitude,
      required this.averageTime,
      required this.description});
}
