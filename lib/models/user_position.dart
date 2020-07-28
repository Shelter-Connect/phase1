import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserPosition extends ChangeNotifier {
  Position _position;

  Position get position => _position;

  set position(Position newPos) {
    _position = newPos;
    notifyListeners();
  }
}