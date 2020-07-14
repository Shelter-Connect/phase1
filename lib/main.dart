import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase1/loading_page.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'pages/login_page.dart';
import 'pages/organization/organization_confirmation_page.dart';
import 'pages/organization/organization_dashboard_page.dart';
import 'pages/organization/organization_navigation_page.dart';
import 'pages/organization/organization_sign_up_page.dart';
import 'pages/signup_page.dart';
import 'pages/volunteer/donation_confirmation_page.dart';
import 'pages/volunteer/items_to_deliver_extended.dart';
import 'pages/volunteer/organization_profile_page.dart';
import 'pages/volunteer/volunteer_confirmation_page.dart';
import 'pages/volunteer/volunteer_donate_page.dart';
import 'pages/volunteer/volunteer_navigation_page.dart';
import 'pages/volunteer/volunteer_sign_up_page.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: auth.onAuthStateChanged,
      child: MaterialApp(
        title: 'Shelter Connect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: colorScheme,
        ),
        routes: {
          '/': (_) => WelcomePage(),
          '/loading_page': (_) => LoadingPage(),
          '/confirm_donation': (_) => DonationConfirmationPage(),
          '/donate': (_) => VolunteerDonatePage(),
          '/items_to_deliver_extended': (_) => ItemsToDeliverExtended(),
          '/login': (_) => LoginPage(),
          '/organization_confirmation': (_) => OrganizationConfirmation(),
          '/organization_dashboard': (_) => OrganizationDashboardPage(),
          '/organization_navigation': (_) => OrganizationNavigationPage(),
          '/organization_sign_up': (_) => OrganizationSignUpPage(),
          '/org_profile': (_) => OrganizationProfilePage(),
          '/signup': (_) => SignupPage(),
          '/shelter_sign_up': (_) => OrganizationSignUpPage(),
          '/volunteer_navigation': (_) => VolunteerNavigationPage(),
          '/volunteer_confirmation': (_) => VolunteerConfirmation(),
          '/volunteer_sign_up': (_) => VolunteerSignUp(),
        },
        initialRoute: '/loading_page',
      ),
    );
  }
}
