import 'dart:math';

import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position> getUserPosition() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

  static double distance(double lat1, double lng1, double lat2, double lng2) {
    //haversine formula
    var p = 0.017453292519943295; // Math.PI / 180
    var a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p)) / 2;

    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }
}
