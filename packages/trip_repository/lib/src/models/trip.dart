import 'package:area_repository/area_repository.dart';

import '../entities/entities.dart';

class Trip {
  String area;
  String budget;
  int days;
  List<Place> place;
  String details;
  Trip({
    required this.area,
    required this.budget,
    required this.days,
    required this.place,
    required this.details,
  });
  TripEntity toEntity() {
    return TripEntity(
      area: area,
      budget: budget,
      days: days,
      place: place,
      details: details,
    );
  }

  static Trip fromEntity(TripEntity entity) {
    return Trip(
      area: entity.area,
      budget: entity.budget,
      days: entity.days,
      place: entity.place,
      details: entity.details,
    );
  }
}
