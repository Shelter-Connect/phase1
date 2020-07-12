import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/rounded_button.dart';
import '../../constants.dart';

class VolunteerConfirmation extends StatefulWidget {
  @override
  _VolunteerConfirmationState createState() => _VolunteerConfirmationState();
}

class _VolunteerConfirmationState extends State<VolunteerConfirmation> {
  FirebaseUser user;

  @override
  void initState() async {
    user = await auth.currentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('A verification email has been sent to ${user.email}', style: headerStyle), //TODO: Input User E-mail in this String
              SizedBox(height: 20.0),
              RoundedButton(
                title: 'Change e-mail Address',
                onPressed: () {
                  auth.currentUser().then((user) {
                    user.delete();
                  });
                },
              ),
              RoundedButton(
                title: 'Resend Verification E-mail',
                onPressed: () {
                  auth.currentUser().then((user) {
                    user.sendEmailVerification();
                  });
                },
              ),
              RoundedButton(
                title: 'Continue',
                onPressed: () async {
                  await user.reload();
                  user = await auth.currentUser();
                  Navigator.pushNamed(context, '/');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
