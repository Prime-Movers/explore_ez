part of 'plan_details_bloc.dart';

sealed class PlanDetailsEvent extends Equatable {
  const PlanDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetArea extends PlanDetailsEvent {
  final String area;
  const GetArea({required this.area});
  @override
  List<Object> get props => [area];
}

class GetDetails extends PlanDetailsEvent {
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String budget;
  const GetDetails(
      {required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.budget});
  @override
  List<Object> get props => [startDate, endDate, startTime, endTime, budget];
}

class GetPlaces extends PlanDetailsEvent {
  final List<Place> places;
  const GetPlaces({required this.places});
  @override
  List<Object> get props => [places];
}
