class UpdateTrailWithMapEntity {
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

  UpdateTrailWithMapEntity(
      {required this.id,
      required this.name,
      required this.images,
      required this.description,
      required this.trailType,
      required this.rating,
      required this.diffculty,
      required this.location,
      required this.mapId,
      required this.mapName,
      required this.mapDestinationLatlang,
      required this.mapStartLatLang,
      required this.mapAltitude,
      required this.mapDistance,
      required this.mapAverageTime,
      required this.mapPolypoints});
}
