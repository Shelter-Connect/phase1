import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  FirebaseUser _user;

  get user => _user;

  set user(FirebaseUser newUser) {
    _user = newUser;
    notifyListeners();
  }
}