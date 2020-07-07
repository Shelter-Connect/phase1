import 'package:flutter/material.dart';

import '../constants.dart';
import '../components/rounded_button.dart';

class VolunteerConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colorScheme.primary,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('A verification e-mail has been sent to this e-mail address: shelterconnect20@gmail.com', style: headerStyle), //TODO: Input User E-mail in this String
            RoundedButton(
              title: 'Change e-mail Address',
              color: Colors.white,
              onPressed: () {
                //TODO: Get rid of Firebase user when this button is clicked
                Navigator.pushNamed(context, '/volunteer_sign_up');
              },
            ),
            SizedBox(height: 30),
            RoundedButton(
              title: 'Resend Verification E-mail',
              color: Colors.white,
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
    );
  }
}
