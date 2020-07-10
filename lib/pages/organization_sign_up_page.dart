import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/floating_text_field.dart';
import '../components/rounded_button.dart';
import '../components/text_button.dart';
import '../constants.dart';

class OrganizationSignUp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String email, password, password2;

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
              Text('Organization Sign Up', style: titleStyle),
              SizedBox(height: 35),
              FloatingTextField(
                hintText: 'Organization Email',
                onChanged: (val) {
                  email = val;
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                obscureText: true,
                hintText: 'Password',
                onChanged: (val) {
                  password = val;
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                obscureText: true,
                hintText: 'Re-enter Password',
                onChanged: (val) {
                  password2 = val;
                },
              ),
              SizedBox(height: 30),
              RoundedButton(
                title: 'Next',
                onPressed: () async {
                  if (password != password2) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                              title: Text('Passwords do Not Match'),
                            ));
                  } else {
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(
                            context, '/organization_sign_up_extended');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: TextButton(
                  text: 'Not an Organization?',
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
