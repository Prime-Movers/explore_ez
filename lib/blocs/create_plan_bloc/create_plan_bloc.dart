import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_repository/plan_repository.dart';
import 'package:area_repository/area_repository.dart';
part 'create_plan_event.dart';
part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  final PlanRepo _planRepo;
  final _selectedAreas = <MyArea>{};
  CreatePlanBloc(this._planRepo) : super(CreatePlanInitial()) {
    on<CreatePlanEvent>((event, emit) {
      if (event is PutAreaEvent) {
        try {
          _planRepo.getArea(event.area);
          emit(PutAreaSuccess());
        } catch (e) {
          emit(PutAreaFailure());
        }
      }

      if (event is GetDetailsEvent) {
        try {
          _planRepo.getArea(_selectedAreas.first);
          _planRepo.getDetails(event.startDate, event.endDate, event.budget,
              event.startTime, event.endTime);
          emit(GetDetailsSuccess());
        } catch (e) {
          emit(GetDetailsFailure());
        }
      }
      if (event is GetPlacesEvent) {
        try {
          List<Place> places = _planRepo.getPlaces();
          if (places.isEmpty) {
            emit(GetPlacesFailure());
          }
          emit(GetPlacesSuccess(places: places));
        } catch (e) {
          emit(GetPlacesFailure());
        }
      }
    });
  }
}
