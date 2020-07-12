import 'package:flutter/material.dart';

class DashboardComp extends StatelessWidget {

  final String boxTitle;
  final Widget column;
  final double height;
  DashboardComp({@required this.boxTitle, this.column, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
        height: height,
//        width: MediaQuery. of(context). size. width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(boxTitle, style: TextStyle(
                  fontSize: 24,
                ),),
                SizedBox(height: 5,),
                Container( //THIS IS THE LINE
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Color(0xFF6576EC),
                      borderRadius: BorderRadius.circular(21)
                  ),
                ),
                column,
                //ADD MORE WIDGETS HERE
              ],
            ),
          ),
        ),

      ),
    );
  }
}