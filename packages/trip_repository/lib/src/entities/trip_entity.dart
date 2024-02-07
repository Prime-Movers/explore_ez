class TripEntity {
  String area;
  String budget;
  int days;
  List<dynamic> places;
  List<dynamic> placesImage;
  String details;
  TripEntity(
      {required this.area,
      required this.budget,
      required this.days,
      required this.places,
      required this.details,
      required this.placesImage});
  Map<String, Object?> toDocument() {
    return {
      'area': area,
      'budget': budget,
      'days': days,
      'places': places,
      'placesImage': placesImage,
      'details': details,
    };
  }

  static TripEntity fromDocument(Map<String, dynamic> doc) {
    return TripEntity(
        area: doc['area'],
        budget: doc['budget'],
        days: doc['days'],
        places: doc['places'],
        details: doc['details'],
        placesImage: doc['placesImage']);
  }
}
