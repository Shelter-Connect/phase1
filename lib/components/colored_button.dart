import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  ColoredButton({this.color, this.textColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
          child: Text(
            'Make a Donation!',
            style: TextStyle(color: textColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
