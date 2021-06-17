import 'package:flutter/material.dart' hide TextButton;

import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/text_button.dart';
import '../constants.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign Up', style: largeTitleStyle),
            SizedBox(height: 20.0),
            RoundedButton(
              title: 'Sign Up As Shelter',
              onPressed: () {
                Navigator.pushNamed(context, '/organization_sign_up');
              },
            ),
            RoundedButton(
              title: 'Sign Up As Volunteer',
              onPressed: () {
                Navigator.pushNamed(context, '/volunteer_sign_up');
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: TextButton1(
                text: 'Existing User? Press here to sign in.',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
