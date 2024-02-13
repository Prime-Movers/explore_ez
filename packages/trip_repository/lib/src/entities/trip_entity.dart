import 'package:area_repository/area_repository.dart';

class TripEntity {
  String area;
  String budget;
  int days;
  List<Place> place;
  String details;
  TripEntity({
    required this.area,
    required this.budget,
    required this.days,
    required this.place,
    required this.details,
  });
  Map<String, Object?> toDocument() {
    return {
      'area': area,
      'budget': budget,
      'days': days,
      'place': place,
      'details': details,
    };
  }

  static TripEntity fromDocument(Map<String, dynamic> doc) {
    List<Map<String, dynamic>> placesData =
        List<Map<String, dynamic>>.from(doc['place']);
    return TripEntity(
      area: doc['area'],
      budget: doc['budget'],
      days: doc['days'],
      place: placesData
          .map((e) => Place.fromEntity(PlaceEntity.fromDocument(e)))
          .toList(),
      details: doc['details'],
    );
  }
}
