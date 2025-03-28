class MapEntity {
// {
//   "id": 1068,
//   "mapName": null,
//   "destinationLatlang": "27.709237449453816, 85.32807670533657",
//   "startLatlang": "27.709237449453816, 85.32807670533657",
//   "altitude": 1.3,
//   "distance": 1.2,
//   "averageTime": "0.3",
//   "polypoints": "sdahDgdwgO|@oBHWJa@BMJGJk@@YaAMaFq@eE_@yK}@{Hk@?MaA@K?uBBYBw@U_@U]Wi@Wo@Oi@Yc@OgAU_@MGSKk@C]K]q@gAQi@MaAEmADoAwAWYG?GAOCGCCVcBf@oDPaA"
// }

  int? id;
  String? mapName;
  String? destinationLatlang;
  String? startLatlang;
  double? altitude;
  double? distance;
  String? polypoints;

  MapEntity(
      {this.id,
      this.mapName,
      this.destinationLatlang,
      this.startLatlang,
      this.altitude,
      this.distance,
      this.polypoints});

// Map<dynamic,String> to

  factory MapEntity.toJson(Map<String, dynamic> json) {
    return MapEntity(
      id: json["id"],
      mapName: json["mapName"],
      destinationLatlang: json["destinationLatlang"],
      startLatlang: json["startLatLang"],
      altitude: json["altitude"],
      distance: json["distance"],
      polypoints: json["polypoints"],
    );
  }
}
