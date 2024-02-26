import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/blocs/tour_plan_model_bloc/tour_plan_model_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_repository/plan_repository.dart';

class PlanData extends StatelessWidget {
  const PlanData({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TourPlanModelBloc>(context)
        .add(GetTourPlan(plan: context.read<PlanDetailsBloc>().state.plan));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TourPlanModelBloc, TourPlanModelState>(
          builder: (context, state) {
            if (state is TourPlanModelLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TourPlanModelSuccess) {
              return ListView(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Daily Plan",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  VerticalList(tourPlan: state.tourPlan),
                ],
              );
            } else {
              return const Center(
                child: Text("An Error Occurred"),
              );
            }
          },
        ),
      ),
    );
  }
}

class VerticalList extends StatelessWidget {
  final List<DayPlan> tourPlan;
  const VerticalList({super.key, required this.tourPlan});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tourPlan.length,
        itemBuilder: (BuildContext context, int index) {
          DayPlan dayPlan = tourPlan[index];

          return VerticalPlaceItem(
            dayPlan: dayPlan,
          );
        },
      ),
    );
  }
}

class VerticalPlaceItem extends StatelessWidget {
  final DayPlan dayPlan;

  const VerticalPlaceItem({super.key, required this.dayPlan});
  @override
  Widget build(BuildContext context) {
    String placeName = dayPlan.placeName;
    String distFromPrevLoc = dayPlan.distFromPrevLoc;
    String entryFee = dayPlan.entryFee;
    String day = dayPlan.day;
    String timeSlot = dayPlan.timeSlot;
    String travelTime = dayPlan.travelTime;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Day $day",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Place : $placeName",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Time Slot :  $timeSlot",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Entry Free :  $entryFee",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Distance From previous place :  $distFromPrevLoc",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "travel time :  $travelTime",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10.0,
              ),
            ),
          ]),
    );
  }
}
