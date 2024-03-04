import 'package:explore_ez/components/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_repository/trip_repository.dart';
import 'package:explore_ez/blocs/get_trip_bloc/get_trip_bloc.dart';
import 'package:explore_ez/screens/home/trip_details.dart';
import 'package:explore_ez/screens/plan_details/search_area.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
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
              child: ActionButton(
                text: "Create you Plan",
                icon: Icons.create,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const SearchAreaScreen();
                    }),
                  );
                },
              ),
            ),
            BlocBuilder<GetTripBloc, GetTripState>(builder: (context, state) {
              if (state is GetTripSuccess) {
                return VerticalList(
                  trips: state.trips,
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
            }),
          ],
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: trips.map((currentTrip) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: VerticalPlaceItem(
                currentTrip: currentTrip,
              ),
            );
          }).toList(),
        ),
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

    return InkWell(
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
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              child: Image.network(
                placeImage,
                width: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      tripName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.wallet,
                            size: 16, color: Color.fromARGB(255, 82, 121, 228)),
                        const SizedBox(width: 5),
                        Text(
                          "Budget: ",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 82, 121, 228),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            budget,
                            style: GoogleFonts.aBeeZee(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.calendar_today,
                            size: 16,
                            color: Color.fromARGB(255, 218, 186, 255)),
                        const SizedBox(width: 5),
                        Text(
                          "Days: ",
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 110, 96, 160),
                          ),
                        ),
                        Text(
                          days,
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
