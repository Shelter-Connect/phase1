import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../components/alerts.dart';
import '../../components/floating_text_field.dart';
import '../../components/rounded_button.dart';
import '../../components/text_button.dart';
import '../../constants.dart';

class VolunteerSignUp extends StatefulWidget {
  @override
  _VolunteerSignUpState createState() => _VolunteerSignUpState();
}

class _VolunteerSignUpState extends State<VolunteerSignUp> {
  String firstName, lastName, email, password, password2;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Volunteer Sign Up', style: titleStyle),
                  SizedBox(height: 35),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FloatingTextField(
                          hintText: 'First Name',
                          onChanged: (val) {
                            firstName = val.trim();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: FloatingTextField(
                          hintText: 'Last Name',
                          onChanged: (val) {
                            lastName = val.trim();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FloatingTextField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    onChanged: (val) {
                      email = val.trim();
                    },
                  ),
                  SizedBox(height: 20),
                  FloatingTextField(
                    hintText: 'Password',
                    obscureText: true,
                    onChanged: (val) {
                      password = val.trim();
                    },
                  ),
                  SizedBox(height: 20),
                  FloatingTextField(
                    hintText: 'Re-enter Password',
                    obscureText: true,
                    onChanged: (val) {
                      password2 = val.trim();
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
                          builder: (_) => NoActionAlert(title: 'Password needs to be at least 6 characters long'),
                        );
                      } else {
                        try {
                          setState(() {
                            loading = true;
                          });
                          final newUser = await auth.createUserWithEmailAndPassword(email: email, password: password);
                          setState(() {
                            loading = false;
                          });
                          if (newUser != null) {
                            db.collection('volunteers').document(newUser.user.uid).setData({
                              'email': email,
                              'name': '$firstName $lastName',
                            });
                            newUser.user.sendEmailVerification();
                          }
                          FocusScope.of(context).unfocus();
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (_) => NoActionAlert(title: 'Invalid Email'),
                          );
                          setState(() {
                            loading = false;
                          });
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
      ),
    );
  }
}
