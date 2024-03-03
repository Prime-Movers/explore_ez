import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:plan_repository/src/Currentlocation.dart';
import 'package:plan_repository/src/maps/consts.dart';
import 'package:plan_repository/src/maps/place.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _chennai = LatLng(13.0827, 80.2707);
  LatLng? _currentP = null;
  List<Place> places = [
    Place("Place 1", LatLng(13.0337397, 80.2670382)),
    Place("Place 3", LatLng(13.0437221, 80.2632539)),
    Place("Place 2", LatLng(12.9133086, 80.2487661)),
  ];
  Map<PolylineId, Polyline> polylines = {};
  int j = 0;
  @override
  void initState() {
    super.initState();
    if (current_location != null) {
      getPolylinePoints(_currentP!, places[0].location).then((coordinates) => {
            generatePolyLineFromPoints(coordinates, "Your location"),
          });
    } else {
      for (int i = 0; i < places.length - 1; i++) {
        getPolylinePoints(places[i].location, places[i + 1].location)
            .then((coordinates) => {
                  generatePolyLineFromPoints(coordinates, places[i].name),
                });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _chennai,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!,
                ),
                for (Place place in places)
                  Marker(
                    markerId: MarkerId(place.name),
                    position: place.location,
                  ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  // ... other methods (unchanged)

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<List<LatLng>> getPolylinePoints(LatLng a, LatLng b) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(a.latitude, a.longitude),
      PointLatLng(b.latitude, b.longitude),
      // travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates, String name) async {
    PolylineId id = PolylineId(name);
    Polyline polyline = Polyline(
        polylineId: id,
        color: Color.fromARGB(255, 5, 5, 240),
        points: polylineCoordinates,
        width: 3);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
