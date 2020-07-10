import 'package:flutter/material.dart';

class FloatingTextField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final bool obscureText;

  FloatingTextField({this.hintText, this.onChanged, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: 1,
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

class FloatingTextFieldWithSearch extends StatelessWidget {
  final String hintText;
  final Function onChanged;

  FloatingTextFieldWithSearch({this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        onChanged: onChanged,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 17),
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class BoxTextField extends StatelessWidget {
  final Function onChanged;
  final String hintText;
  final int maxLines;
  final Color colors;

  BoxTextField(
      {this.onChanged,
      this.hintText,
      this.maxLines = 1,
      this.colors,
      Color fillColor,
      InputDecoration decoration});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//          fillColor: Colors.white,
//          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.white)),
          hintText: hintText,
          hintMaxLines: 100,
        ),
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        maxLines: maxLines,
      ),
    );
  }
}
