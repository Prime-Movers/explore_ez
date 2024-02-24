import 'package:area_repository/src/entities/place_entity.dart';

import '../models/models.dart';

class MyAreaEntity {
  String areaName;
  List<Place> places;
  MyAreaEntity({required this.areaName, required this.places});
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

    return MyAreaEntity(
        areaName: doc['areaName'],
        places: placesData
            .map((e) => Place.fromEntityWithLatLong(
                PlaceEntity.fromDocumentWithLatLong(e)))
            .toList());
  }
}
