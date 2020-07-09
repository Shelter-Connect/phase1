import 'package:flutter/material.dart';

import 'constants.dart';
import 'pages/login_page.dart';
import 'pages/organization_confirmation_page.dart';
import 'pages/organization_sign_up_extended_page.dart';
import 'pages/organization_sign_up_page.dart';
import 'pages/signup_page.dart';
import 'pages/volunteer_confirmation_page.dart';
import 'pages/shelter_navigation_page.dart';
import 'pages/volunteer_sign_up_page.dart';
import 'pages/welcome_page.dart';

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
        '/login': (_) => LoginPage(),
        '/volunteer_confirmation': (_) => VolunteerConfirmation(),
        '/volunteer_navigation': (_) => OrganizationNavigationPage(),
        '/volunteer_sign_up': (_) => VolunteerSignUp(),
        '/organization_confirmation': (_) => OrganizationConfirmation(),
        '/organization_sign_up': (_) => OrganizationSignUpPage(),
        '/organization_sign_up_extended': (_) => OrganizationSignUpExtended(),
        '/signup': (_) => SignupPage(),
      },
      initialRoute: '/',
    );
  }
}
