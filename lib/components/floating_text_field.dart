import 'package:flutter/material.dart';

class FloatingTextField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final int maxLines;

  FloatingTextField({this.hintText, this.onChanged, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        onChanged: onChanged,
        maxLines: maxLines,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 17),
          border: InputBorder.none,
        ),
      ),
    );
  }
}