import 'package:flutter/material.dart' hide TextButton;
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../components/alerts.dart';
import '../components/floating_text_field.dart';
import '../components/rounded_button.dart';
import '../components/text_button.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '', password = '';
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
                  Text('Login', style: largeTitleStyle),
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
                    obscureText: true,
                    controller: passwordController,
                    onChanged: (val) {
                      password = val.trim();
                    },
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      TextButton(
                        text: 'Forgot Password?',
                        textColor: colorScheme.error,
                        onPressed: () {
                          if (email == '') {
                            showDialog(
                              context: context,
                              builder: (_) => NoActionAlert(title: 'Please enter an email'),
                            );
                          } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
                            //is valid email address
                            showDialog(
                              context: context,
                              builder: (_) => NoActionAlert(title: 'Please enter a valid email address.'),
                            );
                          } else
                            try {
                              auth.sendPasswordResetEmail(email: email);
                              showDialog(
                                context: context,
                                builder: (_) => NoActionAlert(title: 'Password reset email sent to $email'),
                              );
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (_) => NoActionAlert(title: 'Invalid Email'),
                              );
                            }
                        },
                      )
                    ],
                  ),
                  RoundedButton(
                    color: purpleAccent,
                    title: 'Sign In',
                    textColor: Colors.white,
                    onPressed: () async {
                      if (email == '') {
                        showDialog(
                          context: context,
                          builder: (_) => NoActionAlert(title: 'Please enter an email'),
                        );
                      } else if ((password == '') || (passwordController.text == '')) {
                        showDialog(
                          context: context,
                          builder: (_) => NoActionAlert(title: 'Please enter a password'),
                        );
                      } else {
                        setState(() {
                          loading = true;
                        });
                        try {
                          await auth.signInWithEmailAndPassword(email: email, password: password);

                          setState(() {
                            loading = false;
                          });
                          FocusScope.of(context).unfocus();
                        } catch (e) {
                          String errorMessage;
                          switch (e.code) {
                            case 'ERROR_INVALID_EMAIL':
                              errorMessage = 'Please enter a valid email address.';
                              break;
                            case 'ERROR_WRONG_PASSWORD':
                              errorMessage = 'Your password is incorrect.';
                              break;
                            case 'ERROR_USER_NOT_FOUND':
                              errorMessage = 'This email address hasn\'t been signed up yet.';
                              break;
                            case 'ERROR_USER_DISABLED':
                              errorMessage = 'A user with this email has been disabled.';
                              break;
                            case 'ERROR_TOO_MANY_REQUESTS':
                              errorMessage = 'Too many attempts. Try again later.';
                              break;
                            case 'ERROR_OPERATION_NOT_ALLOWED':
                              errorMessage = 'Signing in with Email and Password is not enabled.';
                              break;
                            default:
                              errorMessage = 'An undefined Error happened. Please restart the app.';
                          }
                          passwordController.clear();
                          setState(() {
                            loading = false;
                          });
                          showDialog(
                            context: context,
                            builder: (_) => NoActionAlert(title: errorMessage),
                          );
                        }
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: TextButton(
                      text: 'Not an Existing User?',
                      textColor: Colors.blueAccent,
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
