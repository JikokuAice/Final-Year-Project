import 'dart:io';

class CreateTrailWithMap {
  // "trailDtos": {
  //   "name": "string",
  //   "images": [
  //     "string"
  //   ],
  //   "description": "string",
  //   "trailType": "string",
  //   "length": 0,
  //   "elevation": 0
  // },
  // "mapDtos": {
  //   "mapName": "string",
  //   "latitude": 0,
  //   "longitude": 0,
  //   "altitude": 0,
  //   "distance": 0,
  //   "averageTime": "string",
  //   "polypoints": "string" can be serialize to string
  // }
// }

//Trail Related
  String name;
  List<String> images;
  String description;
  String trailType;
  String diffculty;
  String location;
//Map related
  String? mapName = "need to be removed";
  String? destinationLatlang;
  String? startLatlang;
  double? altitude; // all need to be changed in decimal
  double distance;
  String? averageTime;
  String? polypoints;

  CreateTrailWithMap(
      {required this.name,
      required this.images,
      required this.description,
      required this.trailType,
      required this.startLatlang,
      required this.destinationLatlang,
      required this.altitude,
      required this.distance,
      required this.averageTime,
      required this.location,
      this.mapName,
      required this.polypoints,
      required this.diffculty});
}
