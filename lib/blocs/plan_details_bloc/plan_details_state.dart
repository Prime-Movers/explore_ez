part of 'plan_details_bloc.dart';

// ignore: must_be_immutable
class PlanDetailsState extends Equatable {
  String area;
  String startDate;
  String endDate;
  String budget;
  String startTime;
  String endTime;
  List<Place> places;

  PlanDetailsState(this.area, this.startDate, this.endDate, this.budget,
      this.startTime, this.endTime, this.places);

  @override
  List<Object> get props =>
      [area, startDate, endDate, budget, startTime, endTime, places];
}
