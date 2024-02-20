import 'models/models.dart';

abstract class AreaRepo {
  Future<List<MyArea>> getAreas();
  Future<List<MyArea>> searchArea(String value);
  Future<List<String>> getAreaNames();
  Future<List<Place>> getPlaces(String areaName);
  Future<List<String>> searchAreaNames(String value);
}
