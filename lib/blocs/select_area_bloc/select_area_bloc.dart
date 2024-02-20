import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_repository/plan_repository.dart';
import 'package:area_repository/area_repository.dart';
part 'select_area_event.dart';
part 'select_area_state.dart';

class SelectAreaBloc extends Bloc<SelectAreaEvent, SelectAreaState> {
  SelectAreaBloc() : super(const SelectAreaState("")) {
    on<SelectArea>(_onSelectArea);
  }
  void _onSelectArea(SelectArea event, Emitter<SelectAreaState> emit) {
    if (state.selectArea == event.selectedArea) {
      emit(const SelectAreaState(""));
    } else {
      emit(SelectAreaState(event.selectedArea));
    }
  }
}
