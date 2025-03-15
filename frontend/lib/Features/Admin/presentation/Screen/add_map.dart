import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:frontend/Features/Admin/Domain/entity/create_trail_with_map.dart';
import 'package:frontend/Features/Admin/Domain/entity/trail.dart';
import 'package:frontend/Features/Admin/presentation/Bloc/admin_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class AddMap extends StatefulWidget {
  const AddMap({super.key});

  @override
  State<AddMap> createState() => _AddMapState();
}

class _AddMapState extends State<AddMap> {
  Logger log = new Logger();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? _destination;
  LatLng? _startPoint;
  final List<Marker> _markers = <Marker>[];
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String? encodedPolyline;
  var custom = [];
  String distance = "0";
  String altitude = "0";
  String time = "0";
  late BitmapDescriptor startIcon;
  late BitmapDescriptor endIcon;
  late Bloc _adminBloc;

// make sure to initialize before map loading

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.7103, 85.3222),
    zoom: 14.4746,
  );

  @override
  void initState() {
    geticon();
    _adminBloc = BlocProvider.of<AdminBloc>(context);
    super.initState();
  }

  geticon() async {
    var start = await BitmapDescriptor.asset(
        const ImageConfiguration(devicePixelRatio: 3.2),
        "assets/location-pin.png");

    var end = await BitmapDescriptor.asset(
        const ImageConfiguration(devicePixelRatio: 3.2), "assets/races.png");

    setState(() {
      startIcon = start;
      endIcon = end;
    });
  }

  TextStyle labelStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(0, 0, 0, 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomSheet: Container(
      //     width: double.infinity,
      //     height: 180,
      //     child: Column(
      //       children: [
      //         Row(),
      //       ],
      //     )),
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Stack(alignment: Alignment.topCenter, children: [
        GoogleMap(
          tiltGesturesEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onLongPress: (arg) {
            setState(() {
              _markers.removeWhere((m) => m.markerId.value == "2");
              _markers.add(Marker(
                  markerId: const MarkerId("2"),
                  position: arg,
                  draggable: false,
                  icon: endIcon));
              _destination = arg;
              if (_startPoint != null && _destination != null) {
                getPolyLinePoints().then((e) => {
                      generatePolylineFromPoint(e),
                      encodedPolyline = encodePolyline(e),
                      log.i(encodedPolyline),
                      log.e(decodePolyline(encodedPolyline!))
                    });
                distance = findDistanceBetweenCoordinates()!.toStringAsFixed(1);
                var avgtime = findDistanceBetweenCoordinates()! / 4;
                time = avgtime.toStringAsFixed(1);
                _adminBloc.add(FetchElevation(
                    latitude: _destination!.latitude.toString(),
                    longitude: _destination!.longitude.toString()));
              } else {
                toastification.show(
                  context: context,
                  type: ToastificationType.warning,
                  title: const Text('start Marker marker missing '),
                  style: ToastificationStyle.minimal,
                  autoCloseDuration: const Duration(seconds: 6),
                );
              }
            });
          },
          onTap: (arg) {
            setState(() {
              _markers.removeWhere((m) => m.markerId.value == "1");
              _markers.add(Marker(
                  markerId: const MarkerId("1"),
                  position: arg,
                  draggable: false,
                  icon: startIcon));
              _startPoint = arg;
              if (_startPoint != null && _destination != null) {
                getPolyLinePoints().then((e) => {
                      generatePolylineFromPoint(e),
                      encodedPolyline = encodePolyline(e),
                      log.i(encodedPolyline),
                      log.e(decodePolyline(encodedPolyline!))
                    });
                distance = findDistanceBetweenCoordinates()!.toStringAsFixed(1);
                var avgtime = findDistanceBetweenCoordinates()! / 4;
                time = avgtime.toStringAsFixed(1);
              } else {
                toastification.show(
                  context: context,
                  type: ToastificationType.warning,
                  title: const Text('destination marker missing '),
                  style: ToastificationStyle.minimal,
                  autoCloseDuration: const Duration(seconds: 6),
                );
              }
            });
          },
          mapType: MapType.hybrid,
          polylines: Set<Polyline>.of(polylines.values),
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 227, 227, 227)),
            width: 400,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Distance : $distance Km",
                      style: labelStyle,
                    ),
                    Text(
                      "Avg Time : $time Hr ",
                      style: labelStyle,
                    ),
                    BlocBuilder<AdminBloc, AdminState>(
                      buildWhen: (previous, current) {
                        if (previous is ElevationFetchedSuccess &&
                            current is ElevationFetchedSuccess) {
                          return current.elevation != previous.elevation;
                        }
                        return current is ElevationFetchedSuccess;
                      },
                      builder: (context, state) {
                        if (state is ElevationFetchedSuccess) {
                          altitude = state.elevation;
                          return Text(
                            "Altitude : $altitude km ",
                            style: labelStyle,
                          );
                        }
                        return Text(
                          "Altitude : O km",
                          style: labelStyle,
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Start Lat Lang : ${_startPoint?.latitude.toStringAsFixed(1) ?? "0.0"} ,${_startPoint?.longitude.toStringAsFixed(1) ?? "0.0"}  ',
                      style: labelStyle,
                    ),
                    Text(
                      "End Lat Lang :${_destination?.latitude.toStringAsFixed(1) ?? "0.0"} ,${_destination?.longitude.toStringAsFixed(1) ?? "0.0"} ",
                      style: labelStyle,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: const WidgetStatePropertyAll(
                            Color.fromRGBO(0, 0, 0, 1),
                          ),
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.only(
                                left: 40, right: 40, top: 12, bottom: 12),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        onPressed: () async {
                          if (_destination == null) {
                            toastification.show(
                              context: context,
                              type: ToastificationType.warning,
                              title: const Text('destination marker missing'),
                              style: ToastificationStyle.minimal,
                              autoCloseDuration: const Duration(seconds: 6),
                            );
                          } else if (_startPoint == null) {
                            toastification.show(
                              context: context,
                              type: ToastificationType.error,
                              title: const Text('start marker missing'),
                              style: ToastificationStyle.minimal,
                              autoCloseDuration: const Duration(seconds: 6),
                            );
                          } else {
                            var trailForumData = await getTrailModel();

                            List<File> images = [];
                            for (var i in trailForumData.images) {
                              images.add(File(i));
                            }

                            var model = CreateTrailWithMap(
                              name: trailForumData.name,
                              images: trailForumData.images,
                              description: trailForumData.description,
                              trailType: trailForumData.trailType,
                              diffculty: trailForumData.difficulty,
                              location: trailForumData.location!,
                              destinationLatlang:
                                  '${_destination!.latitude.toString()}, ${_destination!.longitude.toString()}',
                              startLatlang:
                                  '${_destination!.latitude.toString()}, ${_destination!.longitude.toString()}',
                              altitude: double.parse(altitude),
                              distance: double.parse(distance),
                              polypoints: encodedPolyline,
                              averageTime: time,
                            );
                            _adminBloc.add(CreateTrailWithMapEvent(
                              createTrailWithMapEntity: model,
                            ));
                            log.e(model.altitude);
                          }
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  Future<List<LatLng>> getPolyLinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints points = PolylinePoints();
    try {
      PolylineResult result = await points.getRouteBetweenCoordinates(
          googleApiKey: "AIzaSyAfVD-fFk1aa4yy4YFesrLIXhxwNHhQtxU",
          request: PolylineRequest(
              origin:
                  PointLatLng(_startPoint!.latitude, _startPoint!.longitude),
              destination:
                  PointLatLng(_destination!.latitude, _destination!.longitude),
              mode: TravelMode.walking));

      if (result.points.isNotEmpty) {
        for (var p in result.points) {
          polylineCoordinates.add(LatLng(p.latitude, p.longitude));
        }
      } else {
        print("error in getpolyLinePoint() on line 111");
      }
    } catch (e) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: const Text('Error !! route cant be drawn !! '),
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(seconds: 6),
      );
    }
    return polylineCoordinates;
  }

  void generatePolylineFromPoint(List<LatLng> polylineCoordinates) async {
    PolylineId polyId = const PolylineId("poly1");
    Polyline polyline = Polyline(
        polylineId: polyId,
        color: const Color.fromARGB(255, 1, 254, 195),
        width: 4,
        points: polylineCoordinates);
    setState(() {
      polylines[polyId] = polyline;
    });
  }

  String encodePolyline(List<LatLng> coordinates) {
    StringBuffer encoded = StringBuffer();
    int lastLat = 0, lastLng = 0;

    for (LatLng point in coordinates) {
      int lat = (point.latitude * 1e5).round();
      int lng = (point.longitude * 1e5).round();

      int deltaLat = lat - lastLat;
      int deltaLng = lng - lastLng;

      lastLat = lat;
      lastLng = lng;

      _encodeValue(deltaLat, encoded);
      _encodeValue(deltaLng, encoded);
    }

    return encoded.toString();
  }

  void _encodeValue(int value, StringBuffer encoded) {
    value = (value < 0) ? ~(value << 1) : (value << 1);
    while (value >= 0x20) {
      encoded.writeCharCode((0x20 | (value & 0x1F)) + 63);
      value >>= 5;
    }
    encoded.writeCharCode(value + 63);
  }

  List<LatLng> decodePolyline(String encodedString) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPoints =
        polylinePoints.decodePolyline(encodedString);
    return decodedPoints.map((p) => LatLng(p.latitude, p.longitude)).toList();
  }

  double? findDistanceBetweenCoordinates() {
    var distance = FlutterMapMath().distanceBetween(
        _startPoint!.latitude,
        _startPoint!.longitude,
        _destination!.latitude,
        _destination!.longitude,
        "meters");
    return distance / 1000;
  }

  void updateUI() {
    setState(() {});
  }

  Future<Trail> getTrailModel() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var trailString = pref.getString("trail_json");
    var trailJsonEncoded = jsonDecode(trailString!);
    var model = Trail.fromJson(trailJsonEncoded);
    return model;
  }
}
