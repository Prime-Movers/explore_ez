import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:area_repository/area_repository.dart';
part 'get_area_event.dart';
part 'get_area_state.dart';

class GetAreaBloc extends Bloc<GetAreaEvent, GetAreaState> {
  final AreaRepo _areaRepo;
  GetAreaBloc(this._areaRepo) : super(GetAreaInitial()) {
    on<GetAreaEvent>((event, emit) async {
      emit(GetAreaLoading());
      try {
        List<MyArea> areas = await _areaRepo.getAreas();
        emit(GetAreaSuccess(areas));
      } catch (e) {
        emit(GetAreaFailure());
      }
    });
  }
}
