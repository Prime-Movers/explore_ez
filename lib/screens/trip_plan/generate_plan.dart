import 'dart:developer';

import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/blocs/tour_plan_model_bloc/tour_plan_model_bloc.dart';
import 'package:explore_ez/components/strings.dart';
import 'package:explore_ez/screens/trip_plan/plan_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratePlan extends StatelessWidget {
  const GeneratePlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "It's Time for Travel",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset(
            tourPlanImage,
            height: 500,
            width: 500,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background,
                foregroundColor: Theme.of(context).colorScheme.onBackground,
                elevation: 10,
              ),
              onPressed: () {
                log(context.read<PlanDetailsBloc>().state.status.toString());
                if (context.read<PlanDetailsBloc>().state.status ==
                    PlanStatus.changed) {
                  BlocProvider.of<TourPlanModelBloc>(context).add(GetTourPlan(
                      plan: context.read<PlanDetailsBloc>().state.plan));
                  context.read<PlanDetailsBloc>().state.status =
                      PlanStatus.fixed;
                }

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const PlanData();
                  }),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(Icons.create),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Generate Tour Plan",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
