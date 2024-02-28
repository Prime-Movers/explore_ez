import 'package:area_repository/area_repository.dart';
import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import '../trip_plan/plan_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewPlan extends StatelessWidget {
  const ReviewPlan({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5), // Light gray background
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<PlanDetailsBloc>(context).add(GetPlan());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const PlanData()),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
      body: BlocBuilder<PlanDetailsBloc, PlanDetailsState>(
        builder: (context, state) {
          var padding2 = Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Use different styles for labels and values
                buildRow("Area Name:", state.area),
                buildRow("Begin Journey:", state.startDate),
                buildRow("Budget:", state.budget),
                buildRow(
                  "Places Selected:",
                  printPlaces(state.places),
                ),
              ],
            ),
          );
          var list = [
            SizedBox(height: 20),
            // Title with a different color and increased font size
            Text(
              "Review Your Plan",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3f51b5), // Blue accent color
              ),
            ),
            SizedBox(height: 20),
            // Use a Card for better visual separation
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: padding2,
            ),
          ];
          var children2 = list;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children2,
            ),
          );
        },
      ),
    );
  }

  Widget buildRow(String label, String value) {
    var text = Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
    var padding2 = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          text,
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
    return padding2;
  }

  String printPlaces(List<Place> places) {
    return places.map((place) => place.placeName).join(', ');
  }
}
