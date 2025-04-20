class TrailDetailModel {
  List<String> images;
  String name;
  String location;
  String difficulty;
  String trailType;
  String averageTime;
  num altitude;
  num distance;
  String description;

  TrailDetailModel({
    required this.images,
    required this.name,
    required this.location,
    required this.difficulty,
    required this.distance,
    required this.trailType,
    required this.altitude,
    required this.averageTime,
    required this.description,
  });

  factory TrailDetailModel.fromJson(Map<String, dynamic> json) {
    return TrailDetailModel(
      images: List.from(json['images']),
      name: json['name'],
      location: json['location'],
      difficulty: json['difficulty'],
      distance: json['maps']['distance'],
      trailType: json['trailType'],
      altitude: json['maps']['altitude'],
      averageTime: json["maps"]["averageTime"],
      description: json["description"],
    );
  }
}
