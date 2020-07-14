import 'package:flutter/material.dart';

class FloatingTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle textStyle;
  final TextStyle hintStyle;

  final String hintText;
  final Function onChanged;
  final Function onTapped;
  final int maxLines;
  final bool autofocus;
  final bool obscureText;
  final IconButton suffixIcon;
  final double width;

  FloatingTextField(
      {this.hintText,
      this.obscureText = false,
      this.onChanged,
      this.maxLines = 1,
      this.onTapped,
      this.suffixIcon,
      this.controller,
      this.textStyle,
      this.hintStyle,
      this.autofocus = false,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextField(
            controller: controller,
            autofocus: autofocus,
            style: textStyle,
            obscureText: obscureText,
            onChanged: onChanged,
            onTap: onTapped,
            maxLines: maxLines,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              hintText: hintText,
              hintStyle: hintStyle,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
