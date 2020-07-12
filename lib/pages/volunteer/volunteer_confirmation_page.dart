import 'package:flutter/material.dart';

import '../../components/no_action_alert.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';

class VolunteerConfirmation extends StatefulWidget {
  @override
  _VolunteerConfirmationState createState() => _VolunteerConfirmationState();
}

class _VolunteerConfirmationState extends State<VolunteerConfirmation> {
  @override
  void initState() {
    auth.currentUser().then((value) {
      user = value;
      super.initState();
    });
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
              Text('A verification email has been sent to }', style: headerStyle), //TODO: Input User E-mail in this String
              SizedBox(height: 20.0),
              RoundedButton(
                title: 'Go Back to Change e-mail Address',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RoundedButton(
                title: 'Resend Verification E-mail',
                onPressed: () {
                  auth.currentUser().then((user) {
                    user.sendEmailVerification();
                    showDialog(
                      context: context,
                      builder: (_) => NoActionAlert(title: 'Verification E-mail Resent.'),
                    );
                  });
                },
              ),
              RoundedButton(
                title: 'Continue',
                onPressed: () async {
                  await user.reload();
                  user = await auth.currentUser();
                  if (user.isEmailVerified)
                    Navigator.pushNamed(context, '/');
                  else {
                    showDialog(
                      context: context,
                      builder: (_) => NoActionAlert(title: 'You have not verified your account.'),
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
