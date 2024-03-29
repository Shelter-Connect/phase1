import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phase1/pages/organization/create_request_page.dart';
import 'package:phase1/pages/organization/delivery_information_page.dart';
import 'package:phase1/pages/organization/organization_navigation_page.dart';
import 'package:phase1/pages/volunteer/volunteer_navigation_page.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/organization/organization_confirmation_page.dart';
import 'pages/organization/organization_sign_up_page.dart';
import 'pages/signup_page.dart';
import 'pages/volunteer/volunteer_confirmation_page.dart';
import 'pages/volunteer/volunteer_sign_up_page.dart';
import 'pages/welcome_page.dart';

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
    precacheImage(AssetImage('assets/foodgivingsmaller.png'), context);

    return ChangeNotifierProvider<User>(
      create: (_) => User(),
      child: MaterialApp(
        title: 'Linkare',
        debugShowCheckedModeBanner: false,
        routes: {
          '/welcome': (_) => WelcomePage(),
          '/': (_) => LoadingPage(),
          '/login': (_) => LoginPage(),
          '/organization_confirmation': (_) => OrganizationConfirmationPage(),
          '/organization_create_request': (_) => CreateRequestPage(),
          '/organization_navigation': (_) => OrganizationNavigationPage(),
          '/organization_sign_up': (_) => OrganizationSignUpPage(),
          '/signup': (_) => SignupPage(),
          '/delivery_information': (_) => DeliveryInformationPage(),
          '/shelter_sign_up': (_) => OrganizationSignUpPage(),
          '/volunteer_navigation': (_) => VolunteerNavigationPage(),
          '/volunteer_confirmation': (_) => VolunteerConfirmation(),
          '/volunteer_sign_up': (_) => VolunteerSignUp(),
        },
        initialRoute: '/',
      ),
    );
  }
}
