import 'package:flutter/material.dart';

import '../components/floating_text_fields.dart';
import '../components/rounded_button.dart';
import '../components/text_button.dart';
import '../constants.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Login', style: titleStyle),
              SizedBox(height: 35),
              FloatingTextField(
                hintText: 'Email',
                onChanged: (val) {
                  //TODO: Update E-mail variable
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                hintText: 'Password',
                onChanged: (val) {
                  //TODO: Update Password Variable
                },
              ),
              SizedBox(height: 30),
              RoundedButton(
                title: 'Sign In',
                onPressed: () {
                  //TODO: Sign in with firebase
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: TextButton(
                  text: 'Not an Existing User?',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
