import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../components/floating_text_field.dart';
import '../components/alerts.dart';
import '../components/rounded_button.dart';
import '../components/text_button.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;
  TextEditingController passwordController = TextEditingController();
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
                    obscureText: true,
                    controller: passwordController,
                    onChanged: (val) {
                      password = val.trim();
                    },
                  ),
                  SizedBox(height: 30),
                  RoundedButton(
                    title: 'Sign In',
                    onPressed: () async {
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
                        print(e);
                        passwordController.clear();
                        setState(() {
                          loading = false;
                        });
                        showDialog(
                          context: context,
                          builder: (_) => NoActionAlert(title: 'Invalid email or password'),
                        );
                      }
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
        ),
      ),
    );
  }
}
