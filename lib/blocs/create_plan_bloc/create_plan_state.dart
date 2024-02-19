part of 'create_plan_bloc.dart';

sealed class CreatePlanState extends Equatable {
  const CreatePlanState();

  @override
  List<Object> get props => [];
}

final class CreatePlanInitial extends CreatePlanState {}

class PutAreaSuccess extends CreatePlanState {}

class PutAreaFailure extends CreatePlanState {}

class GetDetailsFailure extends CreatePlanState {}

class GetDetailsSuccess extends CreatePlanState {}

class GetPlacesSuccess extends CreatePlanState {
  final List<Place> places;
  const GetPlacesSuccess({required this.places});
}

class GetPlacesFailure extends CreatePlanState {}

class PutPlacesSuccess extends CreatePlanState {}

class PutPlacesFailure extends CreatePlanState {}
