part of 'fetch_places_bloc.dart';

sealed class FetchPlacesEvent extends Equatable {
  const FetchPlacesEvent();

  @override
  List<Object> get props => [];
}

class FetchPlaces extends FetchPlacesEvent {
  final String areaName;
  const FetchPlaces({required this.areaName});
}
