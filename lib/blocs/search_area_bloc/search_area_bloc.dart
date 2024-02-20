import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:area_repository/area_repository.dart';
part 'search_area_event.dart';
part 'search_area_state.dart';

class SearchAreaBloc extends Bloc<SearchAreaEvent, SearchAreaState> {
  final AreaRepo _areaRepo;
  SearchAreaBloc(this._areaRepo) : super(SearchAreaInitial()) {
    on<SearchAreaEvent>((event, emit) async {
      if (event is SearchArea) {
        emit(SearchAreaLoading());
        try {
          List<String> areas = await _areaRepo.searchAreaNames(event.value);
          emit(SearchAreaLoaded(areas: areas));
        } catch (e) {
          emit(SearchAreaFailure());
        }
      }
    });
  }
}
