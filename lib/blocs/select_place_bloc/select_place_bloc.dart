import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_place_event.dart';
part 'select_place_state.dart';

class SelectPlaceBloc extends Bloc<SelectPlaceEvent, SelectPlaceState> {
  SelectPlaceBloc() : super(const SelectPlaceState([])) {
    on<PlaceSelected>(_onPlaceSelected);
  }
  void _onPlaceSelected(PlaceSelected event, Emitter<SelectPlaceState> emit) {
    final updatedSelectedPlaces = List<String>.from(state.selectedPlaces);
    if (updatedSelectedPlaces.contains(event.selectPlace)) {
      updatedSelectedPlaces.remove(event.selectPlace);
    } else {
      updatedSelectedPlaces.add(event.selectPlace);
    }
    emit(SelectPlaceState(updatedSelectedPlaces));
  }
}