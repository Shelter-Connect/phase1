import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryDescriptionContainer extends StatelessWidget {
  final String info;

  CategoryDescriptionContainer({@required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      width: 220.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: grey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              info,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
