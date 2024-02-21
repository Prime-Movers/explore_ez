part of 'select_place_bloc.dart';

abstract class SelectPlaceEvent extends Equatable {
  const SelectPlaceEvent();

  @override
  List<Object> get props => [];

  void add(InitializeSelection initializeSelection) {}
}

class InitializeSelection extends SelectPlaceEvent {}

class PlaceSelected extends SelectPlaceEvent {
  final Place selectPlace;
  const PlaceSelected(this.selectPlace);
  @override
  List<Object> get props => [selectPlace];
}
