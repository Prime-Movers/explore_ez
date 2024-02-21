import 'package:area_repository/area_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_place_event.dart';
part 'select_place_state.dart';

class SelectPlaceBloc extends Bloc<SelectPlaceEvent, SelectPlaceState> {
  SelectPlaceBloc() : super(const SelectPlaceState([])) {
    on<InitializeSelection>(_onInitializeSelection);
    on<PlaceSelected>(_onPlaceSelected);
  }

  void _onInitializeSelection(
      InitializeSelection event, Emitter<SelectPlaceState> emit) {
    emit(const SelectPlaceState([]));
  }

  void _onPlaceSelected(PlaceSelected event, Emitter<SelectPlaceState> emit) {
    final updatedSelectedPlaces = List<Place>.from(state.selectedPlaces);
    if (updatedSelectedPlaces.contains(event.selectPlace)) {
      updatedSelectedPlaces.remove(event.selectPlace);
    } else {
      updatedSelectedPlaces.add(event.selectPlace);
    }
    emit(SelectPlaceState(updatedSelectedPlaces));
  }
}
