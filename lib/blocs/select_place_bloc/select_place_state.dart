part of 'select_place_bloc.dart';

enum Status { initialized, uninitialized }

// ignore: must_be_immutable
class SelectPlaceState extends Equatable {
  final List<Place> selectedPlaces;
  SelectPlaceState(this.selectedPlaces, this.status);
  Status status;

  @override
  List<Object> get props => [selectedPlaces];
}
