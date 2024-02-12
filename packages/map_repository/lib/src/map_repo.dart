import 'models/models.dart';

abstract class MapRepo {
  Future<List<MyMap>> getMaps();
}
