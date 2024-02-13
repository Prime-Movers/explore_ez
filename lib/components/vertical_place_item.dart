import 'package:explore_ez/screens/home/Details.dart';
import 'package:flutter/material.dart';
import 'package:trip_repository/trip_repository.dart';

class VerticalPlaceItem extends StatelessWidget {
  final Trip currentTrip;
  const VerticalPlaceItem({super.key, required this.currentTrip});

  @override
  Widget build(BuildContext context) {
    String placeImage = currentTrip.place[0].placeImage;
    String tripName = currentTrip.area;
    String budget = currentTrip.budget;
    String days = currentTrip.days.toString();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        child: SizedBox(
          height: 100.0,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  placeImage,
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15.0),
              SizedBox(
                height: 100.0,
                width: MediaQuery.of(context).size.width - 155,
                child: ListView(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tripName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Budget: $budget",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.blueGrey[300],
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Day of Trip: $days",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return TripDetail(
                  currentTrip: currentTrip,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
