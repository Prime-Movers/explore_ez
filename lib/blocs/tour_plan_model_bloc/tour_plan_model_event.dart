part of 'tour_plan_model_bloc.dart';

sealed class TourPlanModelEvent extends Equatable {
  const TourPlanModelEvent();

  @override
  List<Object> get props => [];
}

class GetTourPlan extends TourPlanModelEvent {
  final MyPlan plan;
  const GetTourPlan({required this.plan});
}
