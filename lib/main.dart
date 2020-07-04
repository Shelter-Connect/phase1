import 'package:flutter/material.dart';

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
      routes: {
        '/': (_) => WelcomePage(),
      },
      initialRoute: '/',
    );
  }
}