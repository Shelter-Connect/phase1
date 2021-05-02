//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart' hide TextButton;
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//
//import '../../components/alerts.dart';
//import '../../components/floating_text_field.dart';
//import '../../components/rounded_button.dart';
//import '../../components/text_button.dart';
//import '../../constants.dart';
//
//class DriverSignUp extends StatefulWidget {
//  @override
//  _DriverSignUpState createState() => _DriverSignUpState();
//}
//
//class _DriverSignUpState extends State<DriverSignUp> {
//  String firstName = '', lastName = '', email = '', password = '', password2 = '';
//  bool loading = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: purpleAccent,
//      body: ModalProgressHUD(
//        inAsyncCall: loading,
//        child: SafeArea(
//          child: Center(
//            child: SingleChildScrollView(
//              padding: EdgeInsets.symmetric(horizontal: 24.0),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  SizedBox(height: 20),
//                  Text('Driver Sign Up', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 47.0, color: Colors.white)),
//                  SizedBox(height: 40),
//                  Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: FloatingTextField(
//                          hintText: 'First Name',
//                          onChanged: (val) {
//                            firstName = val.trim();
//                          },
//                        ),
//                      ),
//                      SizedBox(
//                        width: 20,
//                      ),
//                      Expanded(
//                        child: FloatingTextField(
//                          hintText: 'Last Name',
//                          onChanged: (val) {
//                            lastName = val.trim();
//                          },
//                        ),
//                      ),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  FloatingTextField(
//                    keyboardType: TextInputType.emailAddress,
//                    hintText: 'Email',
//                    onChanged: (val) {
//                      email = val.trim();
//                    },
//                  ),
//                  SizedBox(height: 20),
//                  FloatingTextField(
//                    hintText: 'Password',
//                    obscureText: true,
//                    onChanged: (val) {
//                      password = val.trim();
//                    },
//                  ),
//                  SizedBox(height: 20),
//                  FloatingTextField(
//                    hintText: 'Re-enter Password',
//                    obscureText: true,
//                    onChanged: (val) {
//                      password2 = val.trim();
//                    },
//                  ),
//                  SizedBox(height: 30),
//                  RoundedButton(
//                    color: Colors.white,
//                    title: 'Sign Up',
//                    textColor: purpleAccent,
//                    onPressed: () async {
//                      if (firstName == '') {
//                        showDialog(
//                          context: context,
//                          builder: (_) => NoActionAlert(title: 'Please enter your first name'),
//                        );
//                      } else if (lastName == '') {
//                        showDialog(
//                          context: context,
//                          builder: (_) => NoActionAlert(title: 'Please enter your last name'),
//                        );
//                      } else if (email == '') {
//                        showDialog(
//                          context: context,
//                          builder: (_) => NoActionAlert(title: 'Please enter an email'),
//                        );
//                      } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
//                        //is valid email address
//                        showDialog(
//                          context: context,
//                          builder: (_) => NoActionAlert(title: 'Please enter a valid email address.'),
//                        );
//                      } else if (password == '') {
//                        showDialog(
//                          context: context,
//                          builder: (_) => NoActionAlert(title: 'Please enter a password'),
//                        );
//                      } else if (password2 == '') {
//                        showDialog(
//                          context: context,
//                          builder: (_) => NoActionAlert(title: 'Please re-enter your password'),
//                        );
//                      } else if (password != password2) {
//                        showDialog(
//                          context: context,
//                          builder: (_) => NoActionAlert(title: 'Password needs to be at least 6 characters long'),
//                        );
//                      } else if (password.length < 6) {
//                        showDialog(
//                          context: context,
//                          builder: (_) => NoActionAlert(title: 'Passwords do not match'),
//                        );
//                      } else {
//                        try {
//                          setState(() {
//                            loading = true;
//                          });
//                          final newUser = await auth.createUserWithEmailAndPassword(email: email, password: password);
//                          UserUpdateInfo info = UserUpdateInfo();
//                          info.displayName = '$firstName $lastName';
//                          newUser.user.updateProfile(info);
//                          setState(() {
//                            loading = false;
//                          });
//                          if (newUser != null) {
//                            db.collection('volunteers').document(newUser.user.uid).setData(
//                              {
//                                'email': email,
//                                'firstName': firstName,
//                                'lastName': lastName,
//                              },
//                            );
//                            newUser.user.sendEmailVerification();
//                          }
//                          FocusScope.of(context).unfocus();
//                        } catch (e) {
//                          showDialog(
//                            context: context,
//                            builder: (_) => NoActionAlert(title: 'Invalid Email'),
//                          );
//                          setState(() {
//                            loading = false;
//                          });
//                        }
//                      }
//                    },
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(left: 5.0),
//                    child: TextButton(
//                      text: 'Not a Driver?',
//                      textColor: Colors.white,
//                      onPressed: () {
//                        Navigator.pop(context);
//                      },
//                    ),
//                  ),
//                  SizedBox(height: 20),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
