import 'package:flutter/material.dart';

import '../components/text_field.dart';
import '../components/rounded_button.dart';
import '../components/text_button.dart';
import '../constants.dart';

class ShelterSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Shelter Sign Up', style: titleStyle),
                SizedBox(height: 35),
                FloatingTextField(
                  hintText: 'Enter Organization E-mail',
                  onChanged: (val) {
                    //TODO: Update E-mail variable
                  },
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  hintText: 'Enter Password',
                  onChanged: (val) {
                    //TODO: Update Password Variable
                  },
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  hintText: 'Re-enter Password',
                  onChanged: (val) {
                    //TODO: Update Re-enter Password Variable
                  },
                ),
                SizedBox(height: 30),
                RoundedButton(
                  title: 'Sign Up',
                  onPressed: () {
                    //TODO: Make Sign up go to Volunteer Confirmation
                  },
                ),
                TextButton(
                  text: 'Not a Shelter?',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
