import 'package:flutter/rendering.dart';

class UpdateTrailWithMapModel {
//   "trail": {
//     "id": 0,
//     "name": "string",
//     "images": [
//       "string"
//     ],
//     "description": "string",
//     "trailType": "string",
//     "rating": 0,
//     "difficulty": "string",
//     "location": "string"
//   },
//   "map": {
//     "id": 0,
//     "mapName": "string",
//     "destinationLatlang": "string",
//     "startLatlang": "string",
//     "altitude": 0,
//     "distance": 0,
//     "averageTime": "string",
//     "polypoints": "string"
//   }
// }
  int? id;
  String? name;
  List<String>? images;
  String? description;
  String? trailType;
  int? rating;
  String? diffculty;
  String? location;
  int? mapId;
  String? mapName;
  String? mapDestinationLatlang;
  String? mapStartLatLang;
  double? mapAltitude;
  double? mapDistance;
  String? mapAverageTime;
  String? mapPolypoints;

  UpdateTrailWithMapModel(
      { this.id,
      this.name,
      this.images,
      this.description,
      this.trailType,
      this.rating,
      this.diffculty,
      this.location,
      this.mapId,
      this.mapName,
      this.mapDestinationLatlang,
      this.mapStartLatLang,
      this.mapAltitude,
      this.mapDistance,
      this.mapAverageTime,
      this.mapPolypoints});

  Map<String, dynamic> toJson(UpdateTrailWithMapModel entity) {
    return {
      "trail": {
        "id": entity.id,
        "name": entity.name,
        "images": entity.images,
        "description": entity.description,
        "trailType": entity.trailType,
        "rating": entity.rating,
        "difficulty": entity.diffculty,
        "location": entity.location
      },
      "map": {
        "id": entity.mapId,
        "mapName": entity.mapName,
        "destinationLatlang": entity.mapDestinationLatlang,
        "startLatlang": entity.mapStartLatLang,
        "altitude": entity.mapAltitude,
        "distance": entity.mapDistance,
        "averageTime": entity.mapAverageTime,
        "polypoints": entity.mapPolypoints
      }
    };
  }
}
