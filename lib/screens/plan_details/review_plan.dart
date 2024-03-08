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
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Plan Review',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPlanInfoItem(Icons.location_on, 'Tour Area ',
                          state.area, const Color.fromARGB(255, 243, 170, 136)),
                      _buildPlanInfoItem(
                          Icons.date_range,
                          'From ',
                          state.startDate,
                          const Color.fromARGB(255, 129, 142, 255)),
                      _buildPlanInfoItem(Icons.date_range, 'To ', state.endDate,
                          const Color.fromARGB(255, 137, 74, 255)),
                      _buildPlanInfoItem(Icons.wallet, 'Budget ', state.budget,
                          const Color.fromARGB(255, 245, 131, 201)),
                      _buildPlanInfoItem(
                          Icons.access_time,
                          'Start time ',
                          state.startTime,
                          const Color.fromARGB(255, 161, 104, 175)),
                      _buildPlanInfoItem(
                          Icons.access_time,
                          'End time ',
                          state.endTime,
                          const Color.fromARGB(255, 125, 91, 128)),
                      _buildPlanInfoItem(
                          Icons.hotel_rounded,
                          'Accomodation ',
                          state.hotel.placeName,
                          const Color.fromARGB(255, 124, 104, 236)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected Places:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (Place place in state.places)
                            _buildPlaceItem(place.placeName),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlanInfoItem(
      IconData icon, String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceItem(String place) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.place,
            size: 20,
            color: Colors.green,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              place,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
