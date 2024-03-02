class HotelEntity {
  String placeName;
  String placeImage;
  String latitude;
  String longitude;
  HotelEntity(
      {required this.placeName,
      required this.placeImage,
      required this.latitude,
      required this.longitude});

  static HotelEntity fromDocument(Map<String, dynamic> doc) {
    return HotelEntity(
        placeName: doc['placeName'],
        placeImage: doc['placeImage'],
        latitude: doc['latitude'],
        longitude: doc['longitude']);
  }
}
