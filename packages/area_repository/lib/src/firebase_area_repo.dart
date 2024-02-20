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
  Future<List<String>> getAreaNames() async {
    try {
      return await areaCollection.get().then(
          (value) => value.docs.map((e) => e['areaName'] as String).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Place>> getPlaces(String areaName) async {
    try {
      return await areaCollection
          .where('areaName', isEqualTo: areaName)
          .get()
          .then((value) => value.docs
              .map(
                  (e) => MyArea.fromEntity(MyAreaEntity.fromDocument(e.data())))
              .first
              .places
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MyArea>> searchArea(String value) async {
    if (value.isEmpty) {
      // Return all areas if search query is empty
      return await getAreas();
    }
    try {
      return await areaCollection
          .where(
            'areaName',
            isGreaterThanOrEqualTo: value,
            isLessThanOrEqualTo: '${value}z', // Consider using endAt here
          )
          .get()
          .then((value) => value.docs
              .map(
                  (e) => MyArea.fromEntity(MyAreaEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<String>> searchAreaNames(String value) async {
    if (value.isEmpty) {
      return await getAreaNames();
    }
    try {
      return await areaCollection
          .where(
            'areaName',
            isGreaterThanOrEqualTo: value,
            isLessThanOrEqualTo: '${value}z', // Consider using endAt here
          )
          .get()
          .then((value) =>
              value.docs.map((e) => e['areaName'] as String).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
