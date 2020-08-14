import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phase1/pages/organization/create_request_page.dart';
import 'package:phase1/pages/organization/delivery_information_page.dart';
import 'package:phase1/pages/organization/organization_bottom_navigation.dart';
import 'package:phase1/pages/volunteer/volunteer_bottom_navigation_page.dart';
import 'package:phase1/pages/welcome_updated_v2.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/organization/organization_confirmation_page.dart';
import 'pages/organization/organization_sign_up_page.dart';
import 'pages/signup_page.dart';
import 'pages/volunteer/volunteer_confirmation_page.dart';
import 'pages/volunteer/volunteer_navigation_page.dart';
import 'pages/volunteer/volunteer_sign_up_page.dart';
import 'pages/welcome_page.dart';
import 'pages/welcome_updated.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    precacheImage(AssetImage('assets/logo_svgs/ShelterConnectLogo.png'), context);

    return ChangeNotifierProvider<User>(
      create: (_) => User(),
      child: MaterialApp(
        title: 'Linkare',
        debugShowCheckedModeBanner: false,
        routes: {
          '/welcome': (_) => WelcomePage(),
          '/welcome_updated': (_) => HomePage(),
          '/welcome_updated_2': (_) => HomePage2(),
          '/': (_) => LoadingPage(),
          '/login': (_) => LoginPage(),
          '/organization_confirmation': (_) => OrganizationConfirmationPage(),
          '/organization_create_request': (_) => CreateRequestPage(),
          '/organization_bottom_navigation': (_) => OrganizationBottomNavigationPage(),
          '/organization_sign_up': (_) => OrganizationSignUpPage(),
          '/signup': (_) => SignupPage(),
          '/delivery_information': (_) => DeliveryInformationPage(),
          '/shelter_sign_up': (_) => OrganizationSignUpPage(),
          '/volunteer_navigation': (_) => VolunteerNavigationPage(),
          '/volunteer_bottom_navigation': (_) => VolunteerBottomNavigationPage(),
          '/volunteer_confirmation': (_) => VolunteerConfirmation(),
          '/volunteer_sign_up': (_) => VolunteerSignUp(),
        },
        initialRoute: '/',
      ),
    );
  }
}
