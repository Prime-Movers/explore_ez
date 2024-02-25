import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/blocs/tour_plan_model_bloc/tour_plan_model_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanData extends StatelessWidget {
  const PlanData({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TourPlanModelBloc>(context)
        .add(GetTourPlan(plan: context.read<PlanDetailsBloc>().state.plan));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: BlocBuilder<TourPlanModelBloc, TourPlanModelState>(
        builder: (context, state) {
          if (state is TourPlanModelLoading) {
            return const CircularProgressIndicator();
          } else if (state is TourPlanModelSuccess) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                    child: Text(
                  state.tourPlan,
                  maxLines: 100,
                )),
              ),
            );
          } else {
            return const Center(
              child: Text("An Error Occurred"),
            );
          }
        },
      ),
    );
  }
}
