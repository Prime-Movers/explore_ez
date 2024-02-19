import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_repository/trip_repository.dart';
import 'package:explore_ez/blocs/get_trip_bloc/get_trip_bloc.dart';
import 'package:explore_ez/screens/home/details.dart';
import 'package:explore_ez/screens/plan_details/search_area.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: BlocBuilder<GetTripBloc, GetTripState>(
          builder: (context, state) {
            if (state is GetTripSuccess) {
              return ListView(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Where are you \ngoing?",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        foregroundColor:
                            Theme.of(context).colorScheme.onBackground,
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return SearchAreaScreen();
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
                              "Create your Plan",
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
                  VerticalList(
                    trips: state.trips,
                  ),
                ],
              );
            } else if (state is GetTripLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("An error has occured..."),
              );
            }
          },
        ),
      ),
    );
  }
}

class VerticalList extends StatelessWidget {
  final List<Trip> trips;
  const VerticalList({super.key, required this.trips});

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
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tripName,
                        style: const TextStyle(
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
                        style: const TextStyle(
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
