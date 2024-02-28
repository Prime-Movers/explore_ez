import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String name;
  LatLng location;

  Place(String name, LatLng location)
      : name = name,
        location = location {
    this.name = name;
    this.location = location;
  }
}
