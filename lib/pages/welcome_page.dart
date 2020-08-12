import 'package:flutter/material.dart';

import '../components/rounded_button.dart';
import '../components/text_button.dart';
import '../constants.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.4, 0.6, 0.9],
              colors: [
                Color(0xFFC1D7FF),
                Color(0xFFC7DBFE),
                Color(0xFFDAE5F9),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome!',
                style: largeTitleStyle,
                textAlign: TextAlign.center,
              ),
              Align(
                child: Image.asset('assets/logo_svgs/ShelterConnectLogo.png', height: 150),
                alignment: Alignment.center,
              ),
              SizedBox(height: 10.0),
              Image.asset('assets/logo_svgs/LogoName.png', width: 400),
              Text(
                'Connecting non-profit organizations and kind hearted people',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              RoundedButton(
                title: 'Continue as Volunteer',
                onPressed: () {
                  Navigator.pushNamed(context, '/volunteer_sign_up');
                },
              ),
              RoundedButton(
                title: 'Continue as Organization',
                onPressed: () {
                  Navigator.pushNamed(context, '/organization_sign_up');
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: TextButton(
                  text: 'Existing User? Sign in here.',
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
