import 'package:flutter/material.dart';

import '../components/floating_text_field.dart';
import '../components/no_action_alert.dart';
import '../components/rounded_button.dart';
import '../components/text_button.dart';
import '../constants.dart';

class OrganizationSignUpPage extends StatefulWidget {
  @override
  _OrganizationSignUpPageState createState() => _OrganizationSignUpPageState();
}

class _OrganizationSignUpPageState extends State<OrganizationSignUpPage> {
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
                      builder: (_) => NoActionAlert(title: 'Passwords do not match'),
                    );
                  } else {
                    //TODO: Somehow send the email and password to the organization extended sign up page
                    Navigator.pushNamed(context, '/organization_sign_up_extended');
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
