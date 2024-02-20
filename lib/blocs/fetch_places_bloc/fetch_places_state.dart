part of 'fetch_places_bloc.dart';

sealed class FetchPlacesState extends Equatable {
  const FetchPlacesState();

  @override
  List<Object> get props => [];
}

final class FetchPlacesInitial extends FetchPlacesState {}

class FetchPlacesLoading extends FetchPlacesState {}

class FetchPlacesSuccess extends FetchPlacesState {
  final List<Place> places;
  const FetchPlacesSuccess({required this.places});
}

class FetchPlacesFailure extends FetchPlacesState {}
