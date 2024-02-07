import 'models/models.dart';

abstract class TripRepo {
  Future<List<Trip>> getTrips();
}
