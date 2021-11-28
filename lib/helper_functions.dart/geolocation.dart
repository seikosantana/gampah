import 'package:geolocator/geolocator.dart';

Future<Position?> determinePosition(
    {required void Function() locationNotEnabledCallback,
    required void Function() permissionDeniedCallback}) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    locationNotEnabledCallback();
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      permissionDeniedCallback();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    permissionDeniedCallback();
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  try {
    return await Geolocator.getCurrentPosition();
  } catch (err) {
    return null;
  }
}
