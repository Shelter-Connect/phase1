import 'package:flutter/material.dart';

import '../components/floating_text_field.dart';
import '../components/no_action_alert.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
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
                  controller: passwordController,
                  onChanged: (val) {
                    password = val.trim();
                  },
                ),
                SizedBox(height: 30),
                RoundedButton(
                  title: 'Sign In',
                  onPressed: () async {
                    try {
                      await auth.signInWithEmailAndPassword(email: email, password: password);
                    } catch(e) {
                      passwordController.clear();
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
    );
  }
}
