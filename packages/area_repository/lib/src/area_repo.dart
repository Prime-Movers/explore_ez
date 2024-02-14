import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/models.dart';

abstract class AreaRepo {
  Future<List<MyArea>> getAreas();
  Future<List<MyArea>> searchArea(String value);
}
