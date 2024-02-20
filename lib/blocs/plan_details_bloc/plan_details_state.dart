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
  MyPlan plan;
  PlanDetailsState(this.area, this.startDate, this.endDate, this.budget,
      this.startTime, this.endTime, this.places, this.plan);

  MyPlan toPlan() {
    return MyPlan.withData(
        area: area,
        startDate: startDate,
        endDate: endDate,
        budget: budget,
        startTime: startTime,
        endTime: endTime,
        places: places);
  }

  @override
  List<Object> get props => [
        area,
        startDate,
        endDate,
        budget,
        startTime,
        endTime,
        places,
      ];
}
