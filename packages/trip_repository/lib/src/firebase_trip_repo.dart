import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_repository/trip_repository.dart';

class FirebaseTripRepo implements TripRepo {
  final tripCollection = FirebaseFirestore.instance.collection('Trips');
  @override
  Future<List<Trip>> getTrips() async {
    try {
      return await tripCollection.get().then((value) => value.docs
          .map((e) => Trip.fromEntity(TripEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
