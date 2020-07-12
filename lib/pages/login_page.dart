import 'package:flutter/material.dart';

import '../components/floating_text_field.dart';
import '../components/rounded_button.dart';
import '../components/text_button.dart';
import '../constants.dart';

class LoginPage extends StatelessWidget {
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Login', style: titleStyle),
              SizedBox(height: 35),
              FloatingTextField(
                hintText: 'Email',
                onChanged: (val) {
                  email = val.trim();
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                hintText: 'Password',
                onChanged: (val) {
                  password = val.trim();
                },
              ),
              SizedBox(height: 30),
              RoundedButton(
                title: 'Sign In',
                onPressed: () {
                  auth.signInWithEmailAndPassword(email: email, password: password).catchError((error) {
                    print(Future.error(error).toString());
                  });
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
