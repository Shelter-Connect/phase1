import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

import '../components/rounded_button.dart';
import '../components/text_button.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Welcome and Thank you!', style: titleStyle),
                Image.asset('assets/ShelterConnectLogo.png', height: 250, width: 250 ),
                Image.asset('assets/LogoName.png', width: 400),
                Text(
                  'Connecting non-profit organizations and kind hearted people',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(90.0),
                    color: Color(0xffffff),
                    child: RoundedButton(
                      title: 'Continue as Volunteer',
                      color: Color(0xff0075C1),
                      onPressed: () {
                        //TODO: Make Volunteer Dashboard and have this button go to Volunteer Dashboard
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(90.0),
                  color: Color(0xffffff),
                  child: RoundedButton(
                    title: 'Continue as Shelter',
                    color: Color(0xffffffff),
                    onPressed: () {
                      Navigator.pushNamed(context, '/shelter_sign_up');
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextButton(
                    text: 'Existing User? Sign in here',
                    onPressed: () {
                      //TODO: Make login page and redirect this button to that page
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
