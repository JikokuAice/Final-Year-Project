// ignore: file_names
class GetTrialWithMapModel {
  // {
  // "trail": {
  //   "id": 0,
  //   "name": "string",
  //   "images": [
  //     "string"
  //   ],
  //   "description": "string",
  //   "trailType": "string",
  //   "rating": 0,
  //   "difficulty": "string",
  //   "maps": {
  //     "id": 0,
  //     "mapName": "string",
  //     "destinationLatlang": "string",
  //     "startLatlang": "string",
  //     "altitude": 0,
  //     "distance": 0,
  //     "averageTime": "string",
  //     "polypoints": "string"
  //   }
  // },
  // "map": {
  //   "id": 0,
  //   "mapName": "string",
  //   "destinationLatlang": "string",
  //   "startLatlang": "string",
  //   "altitude": 0,
  //   "distance": 0,
  //   "averageTime": "string",
  //   "polypoints": "string"
  // }

  int? id;
  String? name;
  List<String?>? images;
  String? description;
  String? trailType;
  String? difficulty;
  int? rating;
  String? location;
//Map related
  int? mapId;
  String? mapName = "need to be removed";
  String? destinationLatlang;
  String? startLatlang;
  double? altitude;
  double? distance;
  String? averageTime;
  String? polypoints;

  GetTrialWithMapModel(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.trailType,
      this.difficulty,
      this.rating,
      this.location,
      this.mapId,
      this.mapName,
      this.destinationLatlang,
      this.startLatlang,
      this.altitude,
      this.distance,
      this.averageTime,
      this.polypoints});

  factory GetTrialWithMapModel.fromJson(Map<String, dynamic> json) {
    return GetTrialWithMapModel(
        id: json["id"] as int?,
        name: json["name"] as String?,
        images: json["images"].cast<String>(),
        description: json["description"] as String?,
        trailType: json["trailType"] as String?,
        difficulty: json["difficulty"] as String?,
        location: json["location"] as String?,
        rating: json["rating"] as int?,
        mapId: json["maps"]["id"] as int?,
        mapName: json["maps"]["mapName"] as String?,
        destinationLatlang: json["maps"]["destinationLatlang"] as String?,
        startLatlang: json["maps"]["startLatlang"] as String?,
        altitude: json["maps"]["altitude"] as double?,
        distance: json["maps"]["distance"] as double?,
        averageTime: json["maps"]["averageTime"] as String?,
        polypoints: json["maps"]["polypoints"] as String?);
  }
}
