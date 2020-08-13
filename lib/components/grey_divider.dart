import 'package:flutter/material.dart';

class GreyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 4,
      color: Color(0xFFF5F5F5),
    );
  }
}
