part of 'get_trip_bloc.dart';

sealed class GetTripState extends Equatable {
  const GetTripState();

  @override
  List<Object> get props => [];
}

class GetTripInitial extends GetTripState {}

class GetTripSuccess extends GetTripState {
  final List<Trip> trips;
  const GetTripSuccess(this.trips);
}

class GetTripFailure extends GetTripState {}

class GetTripLoading extends GetTripState {}
