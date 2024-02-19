part of 'select_place_bloc.dart';

class SelectPlaceState extends Equatable {
  final List<Place> selectedPlaces;
  const SelectPlaceState(this.selectedPlaces);

  @override
  List<Object> get props => [selectedPlaces];
}
