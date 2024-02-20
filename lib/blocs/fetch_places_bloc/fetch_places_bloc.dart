import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:area_repository/area_repository.dart';
part 'fetch_places_event.dart';
part 'fetch_places_state.dart';

class FetchPlacesBloc extends Bloc<FetchPlacesEvent, FetchPlacesState> {
  final AreaRepo _areaRepo;
  FetchPlacesBloc(this._areaRepo) : super(FetchPlacesInitial()) {
    on<FetchPlacesEvent>((event, emit) async {
      if (event is FetchPlaces) {
        emit(FetchPlacesLoading());
        try {
          List<Place> places = await _areaRepo.getPlaces(event.areaName);
          emit(FetchPlacesSuccess(places: places));
        } catch (e) {
          emit(FetchPlacesFailure());
        }
      }
    });
  }
}
