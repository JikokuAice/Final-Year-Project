class MapModel {
  int? id;
  String? mapName;
  String? destinationLatlang;
  String? startLatlang;
  double? altitude;
  double? distance;
  String? polypoints;

  MapModel(
      {this.id,
      this.mapName,
      this.destinationLatlang,
      this.startLatlang,
      this.altitude,
      this.distance,
      this.polypoints});

  factory MapModel.toJson(Map<String, dynamic> json) {
    return MapModel(
      id: json["id"],
      mapName: json["mapName"],
      startLatlang: json["startLatlang"],
      destinationLatlang: json["destinationLatlang"],
      altitude: double.parse(json["altitude"].toString()),
      distance: double.parse(json["distance"].toString()),
      polypoints: json["polypoints"],
    );
  }
}
