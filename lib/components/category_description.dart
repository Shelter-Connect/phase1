import 'package:flutter/material.dart';

class CategoryDescriptionContainer extends StatelessWidget {
  final String info;

  CategoryDescriptionContainer({@required this.info});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        info,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
