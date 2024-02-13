import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:area_repository/area_repository.dart';

class FirebaseAreaRepo implements AreaRepo {
  final areaCollection = FirebaseFirestore.instance.collection('Areas');
  @override
  Future<List<MyArea>> getAreas() async {
    try {
      return await areaCollection.get().then((value) => value.docs
          .map((e) => MyArea.fromEntity(MyAreaEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> searchArea(String value) async {
    try {
      return areaCollection
          .orderBy('areaName')
          .startAt([value])
          .endAt(["$value\uf8ff"])
          .get()
          .toString();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
