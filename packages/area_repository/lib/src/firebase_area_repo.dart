import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:area_repository/area_repository.dart';

class FirebaseAreaRepo implements AreaRepo {
  final areaCollection = FirebaseFirestore.instance.collection('Areas');

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
  Future<List<Place>> getHotels(String areaName) async {
    try {
      return await areaCollection
          .where('areaName', isEqualTo: areaName)
          .get()
          .then((value) => value.docs
              .map(
                  (e) => MyArea.fromEntity(MyAreaEntity.fromDocument(e.data())))
              .first
              .hotels
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
      String searchValue =
          value.toLowerCase(); // Convert search value to lowercase
      QuerySnapshot querySnapshot = await areaCollection.get();
      List<String> areaNames = querySnapshot.docs
          .map((doc) => doc['areaName'] as String)
          .where((areaName) => areaName.toLowerCase().contains(searchValue))
          .toList();
      return areaNames;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
