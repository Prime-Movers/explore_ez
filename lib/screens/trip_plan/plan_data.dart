import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_repository/plan_repository.dart';

class PlanData extends StatelessWidget {
  const PlanData({super.key});

  @override
  Widget build(BuildContext context) {
    MyPlan plan = context.read<PlanDetailsBloc>().state.plan;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Center(child: Text(plan.area)),
    );
  }
}
