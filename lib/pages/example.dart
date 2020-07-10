import 'package:flutter/material.dart';

import '../components/standard_layout.dart';

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: 'Example Title',
      menu: true,
      help: true,
      drawerHeaderText: 'Example Drawer Header',
      helpText:
      'Example help text. Example help text. Example help text. Example help text. Example help text. Example help text. Example help text. Example help text. ',
      drawerOptions: [['Example 1', '/example']],
    );
  }
}
