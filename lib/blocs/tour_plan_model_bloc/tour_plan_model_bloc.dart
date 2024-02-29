import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_repository/plan_repository.dart';
part 'tour_plan_model_event.dart';
part 'tour_plan_model_state.dart';

class TourPlanModelBloc extends Bloc<TourPlanModelEvent, TourPlanModelState> {
  final PlanRepo _planRepo;
  TourPlanModelBloc(this._planRepo) : super(TourPlanModelInitial()) {
    on<TourPlanModelEvent>((event, emit) async {
      if (event is GetTourPlan) {
        emit(TourPlanModelLoading());
        try {
          final List<List<DayPlan>> tourPlan =
              await _planRepo.getPlan(event.plan);
          emit(TourPlanModelSuccess(tourPlan: tourPlan));
        } catch (e) {
          emit(TourPlanModelFailure());
        }
      }
    });
  }
}
