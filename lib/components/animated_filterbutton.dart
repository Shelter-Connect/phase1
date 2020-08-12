import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerApp extends StatefulWidget {
  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedContainer Demo'),
        ),
        body: Center(
          child: AnimatedContainer(
            // Use the properties stored in the State class.
            height: 200,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0xFFDEDEDE),
                blurRadius: 20.0,
                spreadRadius: 0.025,
                offset: Offset(
                  0.0,
                  0.0,
                ),
              ),
            ]),
            // Define how long the animation should take.
            duration: Duration(milliseconds: 50),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          // When the user taps the button
          onPressed: () {
            // Use setState to rebuild the widget with new values.
            setState(() {});
          },
        ),
      ),
    );
  }
}
