part of 'tour_plan_model_bloc.dart';

sealed class TourPlanModelState extends Equatable {
  const TourPlanModelState();

  @override
  List<Object> get props => [];
}

final class TourPlanModelInitial extends TourPlanModelState {}

class TourPlanModelLoading extends TourPlanModelState {}

class TourPlanModelSuccess extends TourPlanModelState {
  final List<List<DayPlan>> tourPlan;
  const TourPlanModelSuccess({required this.tourPlan});
}

class TourPlanModelFailure extends TourPlanModelState {}
