import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserPosition extends ChangeNotifier {
  Position _position;

  get position => _position;

  set position(Position newPos) {
    _position = newPos;
    notifyListeners();
  }
}