import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<String?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
        // return 'Location permission denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
      // return 'Location permission denied.';
    }

    Position position = await Geolocator.getCurrentPosition();
    return '${position.latitude}, ${position.longitude}';
  }
}
