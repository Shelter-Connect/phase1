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
      if (user == null) {
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        db.collection('organizations').document(user.uid).get().then((value) {
          if (value['verified'])
            Navigator.pushNamed(context, '/organization_navigation');
          else
            Navigator.pushNamed(context, '/organization_confirmation');
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Welcome as;dlkfjasl;dfkj', style: titleStyle),
            SizedBox(height: 20.0),
            RoundedButton(
              title: 'Continue as a Volunteer',
              onPressed: () {
                //TODO Check for Existing user. IF true, log them in. IF false, show error message
              },
            ),
            RoundedButton(
              title: 'Continue as an Organization',
              onPressed: () {
                Navigator.pushNamed(context, '/organization_sign_up');
              },
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: TextButton(
                text: 'Already Have an Account? Sign in Here.',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
