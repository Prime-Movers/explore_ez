import '../entities/entities.dart';

import 'models.dart';

class MyArea {
  String areaName;
  List<Place> places;
  MyArea({required this.areaName, required this.places});
  MyAreaEntity toEntity() {
    return MyAreaEntity(areaName: areaName, places: places);
  }

  static MyArea fromEntity(MyAreaEntity entity) {
    return MyArea(areaName: entity.areaName, places: entity.places);
  }
}
