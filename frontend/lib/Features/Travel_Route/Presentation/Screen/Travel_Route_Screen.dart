import "package:flutter/material.dart";

import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:frontend/Features/Admin/Domain/entity/trail.dart';

import 'package:frontend/Features/Travel_Route/Domain/Entity/UserActivity_Entity.dart';
import 'package:frontend/Features/Travel_Route/Presentation/Screen/Archeivement_Screen.dart';
import 'package:frontend/Features/Travel_Route/Presentation/bloc/navigation_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class TravelRouteScreen extends StatefulWidget {
  TravelRouteScreen({super.key, this.id});
  int? id;

  @override
  State<TravelRouteScreen> createState() => _TravelRouteScreenState();
}

class _TravelRouteScreenState extends State<TravelRouteScreen> {
  Logger log = Logger();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String userId = "";

  LatLng? _destination;
  LatLng? _startPoint;
  final List<Marker> _markers = <Marker>[];
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String? encodedPolyline;
  var custom = [];
  String distance = "0";
  double distanceCovered = 0.0;
  double speed = 0.0;
  String altitude = "0";
  String timeRemaining = "0";
  String timeElapsed = "0";
  late BitmapDescriptor startIcon;
  late BitmapDescriptor endIcon;
  late BitmapDescriptor userIcon;
  late Bloc _travelBloc;
  late LatLng userPosition = LatLng(26.6646, 87.2718);
  late LatLng routeLocation;
  late LatLng hikingStartPosition;
  Stopwatch _stopwatch = Stopwatch();

//previous data
  LatLng? previousPostition;
  DateTime? previousTime;

// make sure to initialize before map loading

  late CameraPosition _userCameraPostiton = const CameraPosition(
    target: LatLng(26.6633216, 87.3070592),
    zoom: 14.4746,
  );

  late CameraPosition _startCameraPosition;

  @override
  void initState() {
    getUserId();
    geticon();
    updatePosition();
    _travelBloc = BlocProvider.of<NavigationBloc>(context);
    _travelBloc.add(FetchSpecificMapEvent(id: widget.id!));
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updatePosition() async {
    var position = await _determinePosition();
    if (mounted) {
      setState(() {
        userPosition = LatLng(position.latitude, position.longitude);
      });
    }
    addUserMarker();
  }

  geticon() async {
    var start = await BitmapDescriptor.asset(
        const ImageConfiguration(devicePixelRatio: 3.2),
        "assets/location-pin.png");

    var end = await BitmapDescriptor.asset(
        const ImageConfiguration(devicePixelRatio: 3.2), "assets/races.png");

    var user = await BitmapDescriptor.asset(
        const ImageConfiguration(devicePixelRatio: 3.2),
        "assets/navigator.png");

    setState(() {
      startIcon = start;
      endIcon = end;
      userIcon = user;
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is FetchMapFailure) {
            return const Center(
              child: Text("Error"),
            );
          }
          bool _hasAddedMarker = false;
          if (state is FetchMapSucess && !_hasAddedMarker) {
            _hasAddedMarker = true;
            Future.delayed(const Duration(microseconds: 100), () async {
              addStartingMarker(state);
            });

            return Stack(alignment: Alignment.topCenter, children: [
              GoogleMap(
                tiltGesturesEnabled: true,
                markers: Set<Marker>.of(_markers),
                onLongPress: (arg) {},
                onTap: (arg) {},
                mapType: MapType.hybrid,
                polylines: Set<Polyline>.of(polylines.values),
                initialCameraPosition: CameraPosition(
                    target: _startPoint ??
                        LatLng(
                            double.parse(
                                state.entity.startLatlang!.split(",")[0]),
                            double.parse(
                                state.entity.startLatlang!.split(",")[1])),
                    zoom: 18),
                onCameraMove: (position) {},
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
                            "Total Distance : ${distance ?? 0} Km",
                            style: labelStyle,
                          ),
                          Text(
                            "Time Remaining : $timeRemaining  min ",
                            style: labelStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Time Remaining:  ${timeElapsed} ",
                            style: labelStyle,
                          ),
                          Text(
                            "Speed: ${speed.toStringAsFixed(1)} km/hr ",
                            style: labelStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Distance Covered: ${distanceCovered.toStringAsFixed(1)} km/hr ",
                            style: labelStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                  Color.fromRGBO(11, 72, 29, 1),
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
                                var userHikingLocationValidation =
                                    checkUserInHikingArea();
                                if (userHikingLocationValidation) {
                                  addPolymap(state);
                                  addStartingMarker(state);
                                  addDestinationMarket(state);
                                  trackUserLocation(state);
                                  calculateHiking(userPosition, _destination!,
                                      _startPoint!);
                                } else {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.error,
                                    title: const Text(
                                        'Sorry Hike Cant be Started'),
                                    description: const Text(
                                      "\n Please Reach near Hiking Area to Start",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    style: ToastificationStyle.minimal,
                                    autoCloseDuration:
                                        const Duration(seconds: 6),
                                  );
                                }
                              },
                              child: const Text(
                                "Pause",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]);
          }
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.green,
          ));
        },
      ),
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

  void trackUserLocation(FetchMapSucess state) async {
    Stream<Position> serviceStatusStream = Geolocator.getPositionStream();
    serviceStatusStream.listen((e) async {
      if (this.mounted) {
        setState(() {
          userPosition = LatLng(e.latitude, e.longitude);
          _userCameraPostiton = CameraPosition(target: userPosition, zoom: 18);
          altitude = e.altitude.toString();
        });

        if (previousPostition != null && previousTime != null) {
          double distanceIncrement = Geolocator.distanceBetween(
                  previousPostition!.latitude,
                  previousPostition!.longitude,
                  userPosition.latitude,
                  userPosition.longitude) /
              1000;

          Duration timeDifference = DateTime.now().difference(previousTime!);
          double timeInHours = timeDifference.inSeconds /
              3600.0; // convertinf time diffrence in hour

          if (timeInHours > 0) {
            speed = (distanceIncrement / timeInHours);
          }
          distanceCovered += distanceIncrement;

          //calcaulting remaing time
          if (speed > 0) {
            timeRemaining =
                (((double.parse(distance) - distanceCovered) / (speed)) * 60)
                    .toStringAsFixed(1);
          }

          if (_userCameraPostiton.target == _destination) {}
        }
        previousPostition = userPosition;
        previousTime = DateTime.now();
        if (_controller.isCompleted) {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
              CameraUpdate.newCameraPosition(_userCameraPostiton));
        }
        if (timeElapsed == "0") {
          _stopwatch.start();
        }
        setState(() {
          timeElapsed = " ${_stopwatch.elapsed.inMinutes} min";
        });

        var hikeCompleted =
            checkUserCompletedHiking(userPosition, _destination!);
        int userdata = int.parse(userId);
        if (hikeCompleted) {
          _stopwatch.stop();
          _travelBloc.add(AddUserActivityEvent(
              useractivityEntity: UseractivityEntity(
                  timeElapsed: timeRemaining,
                  trailName: state.entity.mapName ?? "no name",
                  avgSpeed: speed.toString(),
                  distanceCovered: distanceCovered.toStringAsFixed(1),
                  userId: int.parse(userId),
                  trailId: widget.id!)));

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ArcheivementScreen(
                      distanceTravelled: distanceCovered.toStringAsFixed(1),
                      speed: speed.toString(),
                      timeTaken: timeElapsed)));
        }
      }
    });
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

  void calculateHiking(
      LatLng userLocation, LatLng destinationLatlang, LatLng startLocation) {
    setState(() {
      distance =
          findDistanceBetweenCoordinates(userLocation, destinationLatlang)!
              .toStringAsFixed(1);
    });
  }

  void addStartingMarker(FetchMapSucess data) async {
    var starting = data.entity.startLatlang?.split(",");
    LatLng startPosition =
        LatLng(double.parse(starting![0]), double.parse(starting[1]));

    setState(() {
      _startPoint = startPosition;
    });

    _markers.add(
      Marker(
          markerId: const MarkerId("2"),
          position: startPosition,
          icon: startIcon),
    );

    setState(() {
      hikingStartPosition = startPosition;
    });
  }

  void addDestinationMarket(FetchMapSucess data) async {
    var destination = data.entity.destinationLatlang?.split(",");
    LatLng endDestination =
        LatLng(double.parse(destination![0]), double.parse(destination[1]));
    setState(() {
      _destination = endDestination;
    });
    log.i(endDestination);
    _markers.add(Marker(
        markerId: const MarkerId("3"),
        position: endDestination,
        icon: endIcon));
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

  double? findDistanceBetweenCoordinates(
      LatLng userPostion, LatLng destination) {
    var distance = FlutterMapMath().distanceBetween(
        userPostion.latitude,
        userPostion.longitude,
        destination.latitude,
        destination.longitude,
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

  Future<void> addPolymap(FetchMapSucess state) async {
    var polylineString = state.entity.polypoints;
    var polylineDecoded = decodePolyline(polylineString!);
    generatePolylineFromPoint(polylineDecoded);
  }

  void addUserMarker() async {
    const userMarkerId = MarkerId("1");
    _markers.clear(); //
    _markers.add(
        Marker(markerId: userMarkerId, position: userPosition, icon: userIcon));
  }

  bool checkUserInHikingArea() {
    double thresholdDistance = 200;
    double distanceBetween = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        hikingStartPosition.latitude,
        hikingStartPosition.longitude);
    if (distanceBetween <= thresholdDistance) {
      return true;
    } else {
      return false;
    }
  }

  bool checkUserCompletedHiking(LatLng userPosition, LatLng destination) {
    double threshold = 20;
    double distanceBetween = Geolocator.distanceBetween(userPosition.latitude,
        userPosition.longitude, destination.latitude, destination.longitude);
    if (distanceBetween <= threshold) {
      return true;
    }
    return false;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {}

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var location = await Geolocator.getCurrentPosition();

    return location;
  }

  Future<void> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString("pId")!;
    });
  }
}
