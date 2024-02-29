import 'package:area_repository/area_repository.dart';
import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/components/visible_button.dart';
import 'package:explore_ez/screens/trip_plan/generate_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewPlan extends StatelessWidget {
  const ReviewPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        title: const Text('Plan Review'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: VisibleButton(
        colorScheme: Theme.of(context).colorScheme,
        visible: true,
        alignment: Alignment.bottomRight,
        isPop: false,
        isPush: false,
        widget: const GeneratePlan(),
        text: "Next",
        onPressed: () {
          BlocProvider.of<PlanDetailsBloc>(context).add(GetPlan());
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const GeneratePlan();
          }));
        },
      ),
      body: BlocBuilder<PlanDetailsBloc, PlanDetailsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPlanInfoItem(Icons.location_on, 'Area Name:', state.area),
                _buildPlanInfoItem(
                    Icons.date_range, 'Start Date:', state.startDate),
                _buildPlanInfoItem(
                    Icons.date_range, 'End Date:', state.endDate),
                _buildPlanInfoItem(Icons.attach_money, 'Budget:', state.budget),
                _buildPlanInfoItem(
                    Icons.access_time, 'Daily Start Time:', state.startTime),
                _buildPlanInfoItem(
                    Icons.access_time, 'Daily End Time:', state.endTime),
                const SizedBox(height: 20),
                const Text(
                  'Selected Places:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  for (Place place in state.places)
                    _buildPlaceItem(place.placeName),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlanInfoItem(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.blue,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(value, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceItem(String place) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.place,
            size: 20,
            color: Colors.green,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              place,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
