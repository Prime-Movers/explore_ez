part of 'create_plan_bloc.dart';

sealed class CreatePlanEvent extends Equatable {
  const CreatePlanEvent();

  @override
  List<Object> get props => [];
}

class PutAreaEvent extends CreatePlanEvent {
  final MyArea area;
  const PutAreaEvent({required this.area});
}

class GetDetailsEvent extends CreatePlanEvent {
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String budget;
  const GetDetailsEvent(
      {required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.budget});
}

class GetPlacesEvent extends CreatePlanEvent {}
