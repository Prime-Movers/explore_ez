import 'package:explore_ez/blocs/get_area_bloc/get_area_bloc.dart';
import 'package:explore_ez/blocs/get_trip_bloc/get_trip_bloc.dart';
import 'package:trip_repository/trip_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Details.dart';
import '../../components/vertical_place_item.dart';
import 'package:explore_ez/components/vertical_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SearchBar(),
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
