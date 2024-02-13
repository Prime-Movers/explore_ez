import 'package:explore_ez/components/vertical_place_item.dart';
import 'package:flutter/material.dart';
import 'package:trip_repository/trip_repository.dart';

class VerticalList extends StatelessWidget {
  final List<Trip> trips;
  const VerticalList({required this.trips});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int index) {
          Trip currentTrip = trips[index];
          return VerticalPlaceItem(
            currentTrip: currentTrip,
          );
        },
      ),
    );
  }
}
