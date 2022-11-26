import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  firebase.User _user;

  firebase.User get user => _user;

  set user(firebase.User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
