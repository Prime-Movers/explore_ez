import 'package:area_repository/area_repository.dart';
import 'package:flutter/material.dart';
import 'package:trip_repository/trip_repository.dart';

class TripDetail extends StatelessWidget {
  final Trip currentTrip;
  const TripDetail({super.key, required this.currentTrip});

  @override
  Widget build(BuildContext context) {
    String tripName = currentTrip.area;
    String budget = currentTrip.budget;
    String days = currentTrip.days.toString();
    String details = currentTrip.details;
    List<String> placeNames = [];
    for (Place place in currentTrip.place) {
      placeNames.add(place.placeName);
    }
    String places =
        placeNames.toString().replaceAll('[', '').replaceAll(']', '');

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10.0),
          buildSlider(currentTrip),
          const SizedBox(height: 20),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tripName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Places Visited :\n$places",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.blueGrey[300],
                    ),
                    maxLines: 10,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  budget,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Days of Trip : $days",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  details,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.background,
        onPressed: () {},
        child: const Icon(
          Icons.book,
        ),
      ),
    );
  }

  buildSlider(Trip currentTrip) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: currentTrip.place.length,
        itemBuilder: (BuildContext context, int index) {
          Place currentPlace = currentTrip.place[index];

          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                currentPlace.placeImage,
                height: 250.0,
                width: MediaQuery.of(context).size.width - 40.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
