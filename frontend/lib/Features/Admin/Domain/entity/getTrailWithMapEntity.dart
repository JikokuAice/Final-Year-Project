// ignore: file_names
import 'dart:ffi';

class GetTrialWithMapEntity {
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

  GetTrialWithMapEntity(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.trailType,
      this.difficulty,
      this.location,
      this.rating,
      this.mapId,
      this.mapName,
      this.destinationLatlang,
      this.startLatlang,
      this.altitude,
      this.distance,
      this.averageTime,
      this.polypoints});
}
