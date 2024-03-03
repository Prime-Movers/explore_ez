part of 'select_hotel_bloc.dart';

sealed class SelectHotelEvent extends Equatable {
  const SelectHotelEvent();

  @override
  List<Object> get props => [];
}

class FetchHotel extends SelectHotelEvent {
  final String areaName;
  const FetchHotel({required this.areaName});
}

class SelectHotel extends SelectHotelEvent {
  final Place hotel;
  const SelectHotel({required this.hotel});
}
