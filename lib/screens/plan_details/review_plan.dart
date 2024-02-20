import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewPlan extends StatelessWidget {
  const ReviewPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
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
