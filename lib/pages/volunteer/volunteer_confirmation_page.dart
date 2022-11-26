import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/alerts.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';
import '../../models/user.dart';

class VolunteerConfirmation extends StatefulWidget {
  @override
  _VolunteerConfirmationState createState() => _VolunteerConfirmationState();
}

class _VolunteerConfirmationState extends State<VolunteerConfirmation> {
  firebase.User user;

  @override
  void initState() {
    user = auth.currentUser;
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
              Text(
                'A verification email has been sent to ${Provider.of<User>(context, listen: false).user.email}',
                style: headerStyle.copyWith(
                  fontSize: 23.0,
                ),
              ),
              SizedBox(height: 20.0),
              RoundedButton(
                title: 'Go Back to Change Email Address',
                textColor: Colors.white,
                color: purpleAccent,
                onPressed: () async {
                  user.delete();
                  db.collection('volunteers').doc(user.uid).delete();
                },
              ),
              RoundedButton(
                title: 'Resend Verification E-mail',
                textColor: Colors.white,
                color: purpleAccent,
                onPressed: () {
                  try {
                    user.sendEmailVerification().then((res) {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Verification Email Resent.'),
                      );
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              RoundedButton(
                title: 'Continue',
                color: purpleAccent,
                textColor: Colors.white,
                onPressed: () async {
                  await user.reload();
                  user = auth.currentUser;
                  if (user.emailVerified) {
                    print('verified');
                    Navigator.pushReplacementNamed(context, '/volunteer_navigation');
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => NoActionAlert(title: 'You have not verified your account yet.'),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
