import 'package:flutter/material.dart';

class CreateRequestInfoContainer extends StatelessWidget {
  final String info;

  CreateRequestInfoContainer({@required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      width: 220.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(info, style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
          ),),
        ],
      ),
    );
  }
}