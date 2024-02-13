import '../entities/entities.dart';

class Place {
  String placeName;
  String placeImage;
  String? longitude;
  String? latitude;
  Place({required this.placeName, required this.placeImage});
  Place.withLatLong(
      {required this.placeName,
      required this.placeImage,
      this.longitude,
      this.latitude});
  PlaceEntity toEntity() {
    return PlaceEntity(placeName: placeName, placeImage: placeImage);
  }

  PlaceEntity toEntityWithLatLong() {
    return PlaceEntity.withLatLong(
        placeName: placeName,
        placeImage: placeImage,
        longitude: longitude,
        latitude: latitude);
  }

  static Place fromEntity(PlaceEntity entity) {
    return Place(placeImage: entity.placeImage, placeName: entity.placeName);
  }

  static Place fromEntityWithLatLong(PlaceEntity entity) {
    return Place.withLatLong(
        placeName: entity.placeImage,
        placeImage: entity.placeImage,
        latitude: entity.latitude,
        longitude: entity.longitude);
  }
}
