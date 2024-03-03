import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:area_repository/area_repository.dart';
import 'package:plan_repository/plan_repository.dart';
part 'plan_details_event.dart';
part 'plan_details_state.dart';

class PlanDetailsBloc extends Bloc<PlanDetailsEvent, PlanDetailsState> {
  PlanDetailsBloc()
      : super(PlanDetailsState("", "", "", "", "", "", const [], MyPlan(),
            PlanStatus.fixed, Place(placeName: "", placeImage: ""))) {
    on<GetArea>(_getArea);
    on<GetDetails>(_getDetails);
    on<GetPlaces>(_getPlaces);
    on<GetPlan>(_getPlan);
  }

  void _getArea(GetArea event, Emitter<PlanDetailsState> emit) {
    emit(state.stateCopyWith(area: event.area));
  }

  void _getDetails(GetDetails event, Emitter<PlanDetailsState> emit) {
    emit(state.stateCopyWith(
      startDate: event.startDate,
      endDate: event.endDate,
      startTime: event.startTime,
      endTime: event.endTime,
      budget: event.budget,
      hotel: event.hotel,
    ));
  }

  void _getPlaces(GetPlaces event, Emitter<PlanDetailsState> emit) {
    emit(state.stateCopyWith(places: event.places));
  }

  void _getPlan(GetPlan event, Emitter<PlanDetailsState> emit) {
    PlanDetailsState details = state;
    MyPlan plan = state.toPlan();
    if (details.plan.places == plan.places) {
      details.status = PlanStatus.fixed;
    } else {
      details.plan = plan;
      details.status = PlanStatus.changed;
    }
    emit(details);
  }
}
