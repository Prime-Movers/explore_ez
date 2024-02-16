import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_repository/plan_repository.dart';
import 'package:area_repository/area_repository.dart';
part 'create_plan_event.dart';
part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  final PlanRepo _planRepo;
  CreatePlanBloc(this._planRepo) : super(CreatePlanInitial()) {
    on<CreatePlanEvent>((event, emit) {
      if (event is GetAreaEvent) {
        try {
          _planRepo.getArea(event.area);
          emit(GetAreaSuccess());
        } catch (e) {
          emit(GetAreaFailure());
        }
      }

      if (event is GetDetailsEvent) {
        try {
          _planRepo.getDetails(event.startDate, event.endDate, event.budget,
              event.startTime, event.endTime);
          emit(GetDetailsSuccess());
        } catch (e) {
          emit(GetDetailsFailure());
        }
      }
    });
  }
}
