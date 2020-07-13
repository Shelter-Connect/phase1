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
  void initState() {
    auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        db.collection('volunteers').document(user.uid).get().then((value) {
          if (value.data != null) {
            if (user.isEmailVerified) {
              Navigator.pushNamed(context, '/volunteer_navigation');
            } else {
              Navigator.pushNamed(context, '/volunteer_confirmation');
            }
          }
        });

        db.collection('organizations').document(user.uid).get().then((value) {
          if (value.data != null) {
            if (value['verified']) {
              Navigator.pushNamed(context, '/organization_navigation');
            } else {
              Navigator.pushNamed(context, '/organization_confirmation');
            }
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome!',
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              Align(
                child: Image.asset('assets/ShelterConnectLogo.png', height: 150),
                alignment: Alignment.center,
              ),
              SizedBox(height: 10.0),
              Image.asset('assets/LogoName.png', width: 400),
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
