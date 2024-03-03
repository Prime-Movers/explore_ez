part of 'select_hotel_bloc.dart';

enum Status { initial, loading, failure, loaded }

class SelectHotelState extends Equatable {
  final List<Place> hotels;
  final Place selectedHotel;
  final Status status;
  const SelectHotelState(this.hotels, this.selectedHotel, this.status);

  SelectHotelState copyWith({
    List<Place>? hotels,
    Place? selectedHotel,
    Status? status,
  }) {
    return SelectHotelState(hotels ?? this.hotels,
        selectedHotel ?? this.selectedHotel, status ?? this.status);
  }

  @override
  List<Object> get props => [hotels, selectedHotel, status];
}
