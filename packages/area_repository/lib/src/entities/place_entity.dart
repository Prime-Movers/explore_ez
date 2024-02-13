class PlaceEntity {
  String placeName;
  String placeImage;
  String? longitude;
  String? latitude;
  PlaceEntity({required this.placeName, required this.placeImage});

  PlaceEntity.withLatLong(
      {required this.placeName,
      required this.placeImage,
      this.latitude,
      this.longitude});

  Map<String, Object?> toDocument() {
    return {
      'placeName': placeName,
      'placeImage': placeImage,
    };
  }

  static PlaceEntity fromDocument(Map<String, dynamic> doc) {
    return PlaceEntity(
        placeName: doc['placeName'], placeImage: doc['placeImage']);
  }

  Map<String, Object?> toDocumentWithLatLong() {
    return {
      'placeName': placeName,
      'placeImage': placeImage,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static PlaceEntity fromDocumentWithLatLong(Map<String, dynamic> doc) {
    return PlaceEntity.withLatLong(
        placeName: doc['placeName'],
        placeImage: doc['placeImage'],
        latitude: doc['latitude'],
        longitude: doc['longitude']);
  }
}
