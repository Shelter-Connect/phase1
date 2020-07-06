import 'package:flutter/material.dart';

import 'pages/volunteer_sign_up_page.dart';
import 'pages/shelter_sign_up_page.dart';
import 'pages/signup_page.dart';
import 'pages/welcome_page.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelter Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme : colorScheme,
      ),
      routes: {
        '/': (_) => WelcomePage(),
        '/volunteer_sign_up': (_) => VolunteerSignUp(),
        '/shelter_sign_up': (_) => ShelterSignUp(),
        '/signup': (_) => SignupPage(),
      },
      initialRoute: '/',
    );
  }
}