import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/blocs/tour_plan_model_bloc/tour_plan_model_bloc.dart';
import 'package:explore_ez/components/action_button.dart';
import 'package:explore_ez/screens/trip_plan/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_repository/plan_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanData extends StatelessWidget {
  const PlanData({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<TourPlanModelBloc, TourPlanModelState>(
      builder: (context, state) {
        if (state is TourPlanModelLoading) {
          return Scaffold(
              appBar: AppBar(automaticallyImplyLeading: false),
              backgroundColor: colorScheme.onBackground,
              body: const Center(child: CircularProgressIndicator()));
        } else if (state is TourPlanModelSuccess) {
          return DefaultTabController(
            length: state.tourPlan.length,
            child: Scaffold(
              backgroundColor: colorScheme.onBackground,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                bottom: TabBar(
                    tabs: state.tourPlan
                        .map((e) => Tab(
                              text: 'Day ${e.first.day}',
                            ))
                        .toList()),
              ),
              body: TabBarView(
                children: state.tourPlan
                    .map((e) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: VerticalList(tourPlan: e)))
                    .toList(),
              ),
            ),
          );
        } else {
          return Scaffold(
              appBar: AppBar(automaticallyImplyLeading: false),
              backgroundColor: colorScheme.onBackground,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.error_outline,
                    size: 50,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Unable to get the Plan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Tap to Reload",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TourPlanModelBloc>(context).add(
                              GetTourPlan(
                                  plan: context
                                      .read<PlanDetailsBloc>()
                                      .state
                                      .plan));
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 30,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        }
      },
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            ActionButton(
                text: "View on Maps",
                icon: Icons.map,
                onPressed: () {
                  /*Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MapViewScreen(
                              plan: tourPlan,
                            )),
                    (Route<dynamic> route) => false,
                  );
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (BuildContext context) {
                  //     return MapViewScreen(
                  //       plan: tourPlan,
                  //     );
                  //   }),
                  // );*/
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return MapViewScreen(
                        plan: tourPlan,
                      );
                    }),
                  );
                }),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: tourPlan.length,
              itemBuilder: (BuildContext context, int index) {
                DayPlan dayPlan = tourPlan[index];

                return PlanItem(
                  dayPlan: dayPlan,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PlanItem extends StatelessWidget {
  final DayPlan dayPlan;

  const PlanItem({super.key, required this.dayPlan});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 255, 112, 16),
                size: 20,
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  dayPlan.placeName,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Divider(color: Colors.grey),
          const SizedBox(height: 12.0),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 8.0),
              Text(
                "Time Slot: ${dayPlan.timeSlot}",
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(
                Icons.currency_rupee,
                color: Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8.0),
              Text(
                "Entry Fee: ${dayPlan.entryFee}",
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(
                Icons.directions,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8.0),
              Text(
                "Distance From Previous Place: ${dayPlan.distFromPrevLoc}",
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(
                Icons.directions_car,
                color: Colors.purple,
                size: 20,
              ),
              const SizedBox(width: 8.0),
              Text(
                "Travel Time: ${dayPlan.travelTime}",
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
