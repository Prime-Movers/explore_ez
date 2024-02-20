import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/components/visible_button.dart';
import 'package:explore_ez/screens/trip_plan/plan_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewPlan extends StatelessWidget {
  const ReviewPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      floatingActionButton: VisibleButton(
        colorScheme: Theme.of(context).colorScheme,
        visible: true,
        alignment: Alignment.bottomRight,
        isPop: false,
        isPush: false,
        widget: Container(),
        text: "Next",
        onPressed: () {
          BlocProvider.of<PlanDetailsBloc>(context).add(GetPlan());
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const PlanData();
          }));
        },
      ),
      body: BlocBuilder<PlanDetailsBloc, PlanDetailsState>(
          builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(" Area Name : "),
                  Text(state.area),
                ],
              ),
              Row(
                children: [
                  const Text(" Begin Journey : "),
                  Text(state.startDate),
                ],
              ),
              Row(
                children: [
                  const Text(" End Journey : "),
                  Text(state.endDate),
                ],
              ),
              Row(
                children: [
                  const Text(" Start Time : "),
                  Text(state.startTime),
                ],
              ),
              Row(
                children: [
                  const Text(" End Time: "),
                  Text(state.endTime),
                ],
              ),
              Row(
                children: [
                  const Text(" Budget : "),
                  Text(state.budget),
                ],
              ),
              Row(
                children: [
                  const Text(" Places Selected : "),
                  Text(state.places.toString()),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
