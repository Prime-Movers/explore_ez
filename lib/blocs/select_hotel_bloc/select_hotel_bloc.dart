import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:area_repository/area_repository.dart';
part 'select_hotel_event.dart';
part 'select_hotel_state.dart';

class SelectHotelBloc extends Bloc<SelectHotelEvent, SelectHotelState> {
  final AreaRepo _areaRepo;
  SelectHotelBloc(this._areaRepo)
      : super(SelectHotelState(
            const [], Place(placeName: "", placeImage: ""), Status.initial)) {
    on<FetchHotel>(_fetchHotels);
    on<SelectHotel>(_selectHotel);
  }

  void _fetchHotels(FetchHotel event, Emitter<SelectHotelState> emit) async {
    try {
      List<Place> hotels = await _areaRepo.getHotels(event.areaName);
      emit(state.copyWith(hotels: hotels, status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void _selectHotel(SelectHotel event, Emitter<SelectHotelState> emit) async {
    emit(state.copyWith(selectedHotel: event.hotel));
  }
}
