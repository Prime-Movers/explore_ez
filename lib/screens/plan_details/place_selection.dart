import 'package:area_repository/area_repository.dart';
import 'package:explore_ez/blocs/create_plan_bloc/create_plan_bloc.dart';
import 'package:explore_ez/blocs/select_place_bloc/select_place_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceSelectionScreen extends StatelessWidget {
  const PlaceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CreatePlanBloc, CreatePlanState>(
          builder: (context, state) {
            if (state is GetPlacesSuccess) {
              return ListView(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Select places to Visit",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  VerticalList(places: state.places),
                ],
              );
            } else {
              return const Center(
                child: Text("Get Plan Details"),
              );
            }
          },
        ),
      ),
    );
  }
}

class VerticalList extends StatelessWidget {
  final List<Place> places;
  const VerticalList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectPlaceBloc, SelectPlaceState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: places.length,
            itemBuilder: (BuildContext context, int index) {
              Place currentPlace = places[index];
              final isSelected =
                  state.selectedPlaces.contains(currentPlace.placeName);
              return VerticalPlaceItem(
                currentPlace: currentPlace,
                isSelected: isSelected,
              );
            },
          ),
        );
      },
    );
  }
}

class VerticalPlaceItem extends StatelessWidget {
  final Place currentPlace;
  final bool isSelected;
  const VerticalPlaceItem(
      {super.key, required this.currentPlace, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    String placeImage = currentPlace.placeImage;
    String placeName = currentPlace.placeName;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: SizedBox(
          height: 100.0,
          child: Row(children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(placeImage,
                  height: 100.0, width: 100.0, fit: BoxFit.cover),
            ),
            const SizedBox(width: 15.0),
            Icon(
              isSelected
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank,
              color: Theme.of(context).colorScheme.background,
              size: 30,
            ),
            const SizedBox(width: 15.0),
            Text(
              placeName,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
          ]),
        ),
        onTap: () {
          BlocProvider.of<SelectPlaceBloc>(context)
              .add(PlaceSelected(placeName));
        },
      ),
    );
  }
}
