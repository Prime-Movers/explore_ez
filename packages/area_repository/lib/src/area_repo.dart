import 'models/models.dart';

abstract class AreaRepo {
  Future<List<MyArea>> getAreas();
  Future<List<MyArea>> searchArea(String value);
}
