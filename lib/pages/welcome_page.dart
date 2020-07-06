import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../components/floating_text_field.dart';
import '../components/rounded_button.dart';
import '../components/text_button.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome to Shelter Connect!',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FloatingTextField(
                      hintText: 'Enter your email',
                      onChanged: (val) {
                        //TODO: Update Password Variable
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  FloatingTextField(
                    hintText: 'Enter your password',
                    onChanged: (val) {
                      //TODO: Update Password Variable
                    },
                  ),
                  SizedBox(height: 10.0),
                  RoundedButton(
                    title: 'LOGIN',
                    onPressed: () {
                      //TODO Check for Existing user. IF true, log them in. IF false, show error message
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: TextButton(
                      text: 'New User? Sign Up Here',
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
