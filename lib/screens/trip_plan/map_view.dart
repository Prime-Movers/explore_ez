import 'package:area_repository/area_repository.dart';
import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:plan_repository/plan_repository.dart';

class MapViewScreen extends StatelessWidget {
  final List<DayPlan> plan;
  const MapViewScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    //variables used in the map file
    PlanRepo planRepo = ModelPlanRepo();
    String area = context.read<PlanDetailsBloc>().state.area;
    List<Place> places = context.read<PlanDetailsBloc>().state.places;
    List<MarkPoint> points = planRepo.getPoints(plan, places, area);
    MarkPoint accomodation =
        planRepo.getCurrentPoint(context.read<PlanDetailsBloc>().state.hotel);
    //variable used

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(accomodation.name),
            Text(displayPoints(points)),
          ],
        ),
      ),
    );
  }

  // fucntions for the necessities
  String displayPoints(List<MarkPoint> points) {
    String str = "";
    for (int i = 0; i < points.length; i++) {
      str +=
          "Name : ${points[i].name}, Latitude : ${points[i].coordinates.latitude},  Longitude : ${points[i].coordinates.longitude}\n";
    }
    return str;
  }
}
