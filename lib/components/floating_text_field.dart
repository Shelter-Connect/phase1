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
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 17),
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
