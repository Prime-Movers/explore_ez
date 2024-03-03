import 'dart:async';

import 'package:area_repository/area_repository.dart';
import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/components/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:plan_repository/plan_repository.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapViewScreen extends StatefulWidget {
  final List<DayPlan> plan;
  const MapViewScreen({super.key, required this.plan});
  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  Map<PolylineId, Polyline> polylines = {};
  LatLng? _currentP;
  List<MarkPoint> places = [];
  final Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  // // fucntions for the necessities
  // String displayPoints(List<MarkPoint> points) {
  //   String str = "";
  //   for (int i = 0; i < points.length; i++) {
  //     str +=
  //         "Name : ${points[i].name}, Latitude : ${points[i].coordinates.latitude},  Longitude : ${points[i].coordinates.longitude}\n";
  //   }
  //   return str;
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    //variables used in the map file
    PlanRepo planRepo = ModelPlanRepo();
    String area = context.read<PlanDetailsBloc>().state.area;
    List<Place> place = context.read<PlanDetailsBloc>().state.places;
    List<MarkPoint> points = planRepo.getPoints(widget.plan, place, area);
    MarkPoint accomodation =
        planRepo.getCurrentPoint(context.read<PlanDetailsBloc>().state.hotel);
    //variable used
    setState(() {
      _currentP = accomodation.coordinates;
      places = points;
    });
    // @override
    void functions() {
      // super.initState();
      getPolylinePoints(accomodation.coordinates, points[0].coordinates)
          .then((coordinates) => {
                generatePolyLineFromPoints(coordinates, accomodation.name),
              });

      for (int i = 0; i < points.length - 1; i++) {
        getPolylinePoints(points[i].coordinates, points[i + 1].coordinates)
            .then((coordinates) => {
                  generatePolyLineFromPoints(coordinates, points[i].name),
                });
      }
    }

    functions();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      // ignore: unnecessary_null_comparison
      body: GoogleMap(
        onMapCreated: ((GoogleMapController controller) =>
            _mapController.complete(controller)),
        initialCameraPosition: CameraPosition(
          target: accomodation.coordinates,
          zoom: 13,
        ),
        markers: {
          Marker(
            markerId: MarkerId(accomodation.name),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            position: _currentP!,
          ),
          for (MarkPoint place in points)
            Marker(
              markerId: MarkerId(place.name),
              position: place.coordinates,
            ),
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
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
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      // print(result.errorMessage);
    }
    // print(polylineCoordinates);
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
    polylines[id] = polyline;
  }
}
