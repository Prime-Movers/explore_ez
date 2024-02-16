part of 'create_plan_bloc.dart';

sealed class CreatePlanState extends Equatable {
  const CreatePlanState();

  @override
  List<Object> get props => [];
}

final class CreatePlanInitial extends CreatePlanState {}

class GetAreaFailure extends CreatePlanState {}

class GetDetailsFailure extends CreatePlanState {}

class GetAreaSuccess extends CreatePlanState {}

class GetDetailsSuccess extends CreatePlanState {}

class SelectPlacesSuccess extends CreatePlanState {
  final List<Place> places;
  const SelectPlacesSuccess({required this.places});
}

class SelectPlacesFailure extends CreatePlanState {}
