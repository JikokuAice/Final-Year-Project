import 'dart:io';

class CreateTrailWithMapModel {
  String name;
  List<String> images;
  String description;
  String trailType;
  String difficulty;
  String location;
//Map related
  String? mapName = "need to be removed";
  String? destinationLatlang;
  String? startLatlang;
  double? altitude;
  double distance;
  String? averageTime;
  String? polypoints;

  CreateTrailWithMapModel(
      {required this.name,
      required this.images,
      required this.description,
      required this.trailType,
      required this.startLatlang,
      required this.destinationLatlang,
      required this.altitude,
      required this.distance,
      required this.location,
      this.averageTime,
      required this.mapName,
      this.polypoints,
      required this.difficulty});

  Map<String, dynamic> toJson() {
    return {
      "trailDtos": {
        "name": name,
        "images": images,
        "description": description,
        "trailType": trailType,
        "difficulty": difficulty,
        "location": location,
      },
      "mapDtos": {
        "mapName": mapName,
        "destinationLatlang": destinationLatlang,
        "startLatlang": startLatlang,
        "altitude": altitude,
        "distance": distance,
        "averageTime": averageTime,
        "polypoints": polypoints ?? "0,1,02 test"
      }
    };
  }
}
