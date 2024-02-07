import '../entities/entities.dart';

class Trip {
  String area;
  String budget;
  int days;
  List<String> places;
  List<String> placesImage;
  String details;
  Trip(
      {required this.area,
      required this.budget,
      required this.days,
      required this.places,
      required this.details,
      required this.placesImage});
  TripEntity toEntity() {
    return TripEntity(
        area: area,
        budget: budget,
        days: days,
        places: places,
        details: details,
        placesImage: placesImage);
  }

  static Trip fromEntity(TripEntity entity) {
    return Trip(
        area: entity.area,
        budget: entity.budget,
        days: entity.days,
        places: entity.places,
        details: entity.details,
        placesImage: entity.placesImage);
  }
}
