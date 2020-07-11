import 'package:flutter/material.dart';

class FloatingTextField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final Function onTapped;
  final int maxLines;
  final bool obscureText;
  final IconButton suffixIcon;
  FloatingTextField({this.hintText, this.obscureText = false, this.onChanged, this.maxLines = 1, this.onTapped, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        onTap: onTapped,
        maxLines: maxLines,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 17),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
