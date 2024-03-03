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
        places: places,
        accomodation: hotel);
  }

  PlanDetailsState stateCopyWith({
    String? area,
    String? startDate,
    String? endDate,
    String? budget,
    String? startTime,
    String? endTime,
    List<Place>? places,
    MyPlan? plan,
    PlanStatus? status,
    Place? hotel,
  }) {
    return PlanDetailsState(
      area ?? this.area,
      startDate ?? this.startDate,
      endDate ?? this.endDate,
      budget ?? this.budget,
      startTime ?? this.startTime,
      endTime ?? this.endTime,
      places ?? this.places,
      plan ?? this.plan,
      status ?? this.status,
      hotel ?? this.hotel,
    );
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
        hotel,
      ];
}
