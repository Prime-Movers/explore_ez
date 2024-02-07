import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_repository/trip_repository.dart';
part 'get_trip_event.dart';
part 'get_trip_state.dart';

class GetTripBloc extends Bloc<GetTripEvent, GetTripState> {
  final TripRepo _tripRepo;
  GetTripBloc(this._tripRepo) : super(GetTripInitial()) {
    on<GetTripEvent>((event, emit) async {
      emit(GetTripLoading());
      try {
        List<Trip> trips = await _tripRepo.getTrips();
        emit(GetTripSuccess(trips));
      } catch (e) {
        emit(GetTripFailure());
      }
    });
  }
}
