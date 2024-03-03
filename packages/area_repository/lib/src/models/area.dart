import '../entities/entities.dart';

import 'models.dart';

class MyArea {
  String areaName;
  List<Place> places;
  List<Place> hotels;
  MyArea({required this.areaName, required this.places, required this.hotels});
  MyAreaEntity toEntity() {
    return MyAreaEntity(areaName: areaName, places: places, hotels: hotels);
  }

  static MyArea fromEntity(MyAreaEntity entity) {
    return MyArea(
        areaName: entity.areaName,
        places: entity.places,
        hotels: entity.hotels);
  }
}
