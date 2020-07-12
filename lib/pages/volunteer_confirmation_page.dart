import 'package:flutter/material.dart';

import '../components/rounded_button.dart';
import '../constants.dart';

class VolunteerConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('A verification code has been sent to email address', style: headerStyle), //TODO: Input User E-mail in this String
                RoundedButton(
                  title: 'Change e-mail Address',
                  color: colorScheme.background,
                  onPressed: () {
                    //TODO: Get rid of Firebase user when this button is clicked
                    Navigator.pushNamed(context, '/volunteer_sign_up');
                  },
                ),
                SizedBox(height: 30),
                RoundedButton(
                  title: 'Resend Verification E-mail',
                  color: colorScheme.background,
                  onPressed: () {
                    //TODO: Resend Verification E-mail
                  },
                ),
                SizedBox(height: 50),
                RoundedButton(
                  title: 'Continue',
                  onPressed: () {
                    //TODO: Go to Volunteer Request Page
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
