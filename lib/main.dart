import 'package:flutter/material.dart';

import 'pages/signup_page.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelter Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        buttonColor: Color(0xff26A0FF),
      ),
      routes: {
        '/': (_) => WelcomePage(),
        '/signup': (_) => SignupPage(),
      },
      initialRoute: '/',
    );
  }
}