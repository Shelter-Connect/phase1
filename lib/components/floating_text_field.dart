import 'package:flutter/material.dart';

class FloatingTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle textStyle;
  final TextStyle hintStyle;

  final String hintText;
  final Function onChanged;
  final Function onTapped;
  final int maxLength;
  final int maxLines;
  final bool autofocus;
  final bool obscureText;
  final IconButton suffixIcon;
  final double width;
  final TextInputType keyboardType;

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
      this.width,
      this.maxLength,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
        child: TextField(
          controller: controller,
          autofocus: autofocus,
          style: textStyle,
          obscureText: obscureText,
          onChanged: onChanged,
          onTap: onTapped,
          maxLength: maxLength,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
            hintText: hintText,
            hintStyle: hintStyle,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class FloatingDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle textStyle;
  final TextStyle hintStyle;

  final String hintText, counterText, labelText;
  final Function onChanged;
  final Function onTapped;
  final int maxLength;
  final int maxLines;
  final bool autofocus;
  final bool obscureText;
  final IconButton suffixIcon;
  final double width, height;
  final TextInputType keyboardType;
  final TextStyle labelStyle;

  FloatingDescriptionField(
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
      this.width,
        this.height,
      this.maxLength,
        this.counterText,
        this.labelText,
        this.labelStyle,
      this.keyboardType = TextInputType.text,});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
        child: TextField(
          controller: controller,
          autofocus: autofocus,
          style: textStyle,
          obscureText: obscureText,
          onChanged: onChanged,
          onTap: onTapped,
          maxLength: maxLength,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
            hintText: hintText,
            hintStyle: hintStyle,
            border: InputBorder.none,
            counterText: counterText,
            labelText: labelText,
            labelStyle: labelStyle,
          ),
        ),
      ),
    );
  }
}
