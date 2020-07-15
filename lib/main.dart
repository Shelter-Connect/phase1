import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'models/user.dart';
import 'pages/loading_page.dart';
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
    precacheImage(AssetImage('assets/ShelterConnectLogo.png'), context);

    return ChangeNotifierProvider<User>(
      create: (_) => User(),
      child: MaterialApp(
        title: 'Shelter Connect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: colorScheme,
        ),
        routes: {
          '/': (_) => WelcomePage(),
          '/loading': (_) => LoadingPage(),
          '/confirm_donation': (_) => DonationConfirmationPage(),
          '/donate': (_) => VolunteerDonatePage(),
          '/items_to_deliver_extended': (_) => ItemsToDeliverExtended(),
          '/login': (_) => LoginPage(),
          '/organization_confirmation': (_) => OrganizationConfirmationPage(),
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
        initialRoute: '/loading',
      ),
    );
  }
}
