part of 'get_trip_bloc.dart';

sealed class GetTripEvent extends Equatable {
  const GetTripEvent();

  @override
  List<Object> get props => [];
}

class GetTrip extends GetTripEvent {}
