import 'package:area_repository/src/entities/hotel_entity.dart';

class Hotel {
  String placeName;
  String placeImage;
  String latitude;
  String longitude;
  Hotel(
      {required this.placeName,
      required this.placeImage,
      required this.latitude,
      required this.longitude});

  static Hotel fromEntity(HotelEntity entity) {
    return Hotel(
        placeName: entity.placeName,
        placeImage: entity.placeImage,
        latitude: entity.latitude,
        longitude: entity.longitude);
  }
}
