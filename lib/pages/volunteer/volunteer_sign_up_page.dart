import 'package:flutter/material.dart';

import '../../components/floating_text_field.dart';
import '../../components/no_action_alert.dart';
import '../../components/rounded_button.dart';
import '../../components/text_button.dart';
import '../../constants.dart';

class VolunteerSignUp extends StatefulWidget {
  @override
  _VolunteerSignUpState createState() => _VolunteerSignUpState();
}

class _VolunteerSignUpState extends State<VolunteerSignUp> {
  String email, password, password2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Volunteer Sign Up', style: titleStyle),
                SizedBox(height: 35),
                FloatingTextField(
                  hintText: 'Email',
                  onChanged: (val) {
                    email = val;
                  },
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (val) {
                    password = val;
                  },
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  hintText: 'Re-enter Password',
                  obscureText: true,
                  onChanged: (val) {
                    password2 = val;
                  },
                ),
                SizedBox(height: 30),
                RoundedButton(
                  title: 'Sign Up',
                  onPressed: () async {
                    if (password != password2) {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Passwords do not match'),
                      );
                    } else if (password.length < 6) {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Passwords needs to be at least 6 characters in length'),
                      );
                    } else {
                      try {
                        final newUser = await auth.createUserWithEmailAndPassword(email: email, password: password);
                        if (newUser != null) {
                          await db.collection('volunteers').document(newUser.user.uid).setData({
                            'email': email,
                          });
                          newUser.user.sendEmailVerification();
                        }
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (_) => NoActionAlert(title: 'Invalid Email'),
                        );
                      }
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextButton(
                    text: 'Not a Volunteer?',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
