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
  String email, password, password2, organizationName, description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Organization Sign Up', style: titleStyle),
              SizedBox(height: 35),
              FloatingTextField(
                hintText: 'Organization Email',
                onChanged: (val) {
                  email = val.trim();
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                obscureText: true,
                hintText: 'Password',
                onChanged: (val) {
                  password = val.trim();
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                obscureText: true,
                hintText: 'Re-enter Password',
                onChanged: (val) {
                  password2 = val.trim();
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                hintText: 'Organization Name',
                onChanged: (val) {
                  organizationName = val.trim();
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                onChanged: (val) {
                  setState(() {
                    description = val;
                  });
                },
                maxLines: null,
                hintText: 'Short Description of Organization',
              ),
              SizedBox(height: 20),
              FloatingTextField(
                hintText: 'Organization Location',
                onChanged: (val) {
                  //TODO: Update Organization Location Variable, have autocomplete feature to make it easy to find exact shelter location.
                },
              ),
              SizedBox(height: 30),
              RoundedButton(
                title: 'Create Account',
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
                        await db.collection('organizations').document(newUser.user.uid).setData({
                          'description': description,
                          'email': email,
                          'name': organizationName,
                          'location': null,
                          'verified': false,
                        });
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
