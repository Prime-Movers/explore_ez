import "dart:async";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:location/location.dart";

class CurrentLocation {
  LatLng? currentlocation;
  final Location _locationController = Location();

  Future<LatLng?> getLocation() async {
    currentlocation = (await _locationController.getLocation()) as LatLng?;
    return currentlocation;
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        currentlocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      }
    });
  }
}
