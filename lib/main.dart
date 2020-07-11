import 'package:flutter/material.dart';
import 'package:phase1/pages/volunteer/volunteer_navigation_page.dart';


import 'constants.dart';
import 'pages/login_page.dart';
import 'pages/organization/organization_confirmation_page.dart';
import 'pages/organization/organization_dashboard_page.dart';
import 'pages/organization/organization_navigation_page.dart';
import 'pages/organization/organization_sign_up_page.dart';
import 'pages/signup_page.dart';
import 'pages/volunteer/volunteer_confirmation_page.dart';
import 'pages/volunteer/volunteer_navigation_page.dart';
import 'pages/volunteer/volunteer_sign_up_page.dart';
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
        colorScheme: colorScheme,
      ),
      routes: {
        '/': (_) => WelcomePage(),
        '/login': (_) => LoginPage(),
        '/organization_confirmation': (_) => OrganizationConfirmation(),
        '/organization_dashboard': (_) => OrganizationDashboardPage(),
        '/organization_navigation': (_) => OrganizationNavigationPage(),
        '/organization_sign_up': (_) => OrganizationSignUpPage(),
        '/signup': (_) => SignupPage(),
        '/volunteer_navigation': (_) => VolunteerNavigationPage(),
        '/volunteer_confirmation': (_) => VolunteerConfirmation(),
        '/volunteer_sign_up': (_) => VolunteerSignUp(),
      },
      initialRoute: '/organization_sign_up',
    );
  }
}
