part of 'select_place_bloc.dart';

class SelectPlaceState extends Equatable {
  final List<String> selectedPlaces;
  const SelectPlaceState(this.selectedPlaces);

  @override
  List<Object> get props => [selectedPlaces];
}
