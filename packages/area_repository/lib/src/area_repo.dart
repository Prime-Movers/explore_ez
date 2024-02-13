import 'models/models.dart';

abstract class AreaRepo {
  Future<List<MyArea>> getAreas();
  Future<String> searchArea(String value);
}
