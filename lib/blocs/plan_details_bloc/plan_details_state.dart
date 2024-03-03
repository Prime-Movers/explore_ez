part of 'plan_details_bloc.dart';

enum PlanStatus { changed, fixed, initial }

// ignore: must_be_immutable
class PlanDetailsState extends Equatable {
  String area;
  String startDate;
  String endDate;
  String budget;
  String startTime;
  String endTime;
  List<Place> places;
  Place hotel;
  PlanStatus status;
  MyPlan plan;
  PlanDetailsState(
      this.area,
      this.startDate,
      this.endDate,
      this.budget,
      this.startTime,
      this.endTime,
      this.places,
      this.plan,
      this.status,
      this.hotel);

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

  MyPlan copyWith(MyPlan plan) {
    return MyPlan.withData(
        area: plan.area,
        startDate: plan.startDate,
        endDate: plan.endDate,
        budget: plan.budget,
        startTime: plan.startTime,
        endTime: plan.endTime,
        places: plan.places);
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
