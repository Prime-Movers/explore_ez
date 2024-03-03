import 'package:area_repository/src/entities/place_entity.dart';

import '../models/models.dart';

class MyAreaEntity {
  String areaName;
  List<Place> places;
  List<Place> hotels;
  MyAreaEntity(
      {required this.areaName, required this.places, required this.hotels});
  Map<String, Object?> toDocument() {
    return {
      'areaName': areaName,
      'places': places
          .map((e) => e.toEntityWithLatLong().toDocumentWithLatLong())
          .toList(),
    };
  }

  static MyAreaEntity fromDocument(Map<String, dynamic> doc) {
    List<Map<String, dynamic>> placesData =
        List<Map<String, dynamic>>.from(doc['Place']);

    List<Map<String, dynamic>> hotelsData =
        List<Map<String, dynamic>>.from(doc['Hotels']);
    return MyAreaEntity(
        areaName: doc['areaName'],
        places: placesData
            .map((e) => Place.fromEntityWithLatLong(
                PlaceEntity.fromDocumentWithLatLong(e)))
            .toList(),
        hotels: hotelsData
            .map((e) => Place.fromEntityWithLatLong(
                PlaceEntity.fromDocumentWithLatLong(e)))
            .toList());
  }
}
