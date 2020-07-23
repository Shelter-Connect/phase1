import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

class CurrentRequestDeliveryContainer extends StatelessWidget {
  final List itemName, itemQuantity;
  final String deliveryId;
  final String category;

  CurrentRequestDeliveryContainer({this.itemName, this.itemQuantity, this.deliveryId, this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
      child: Container(
        decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$category',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  //THIS IS THE LINE
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(

                      children:  <Widget>[...itemQuantity.map((int) => Text('$int', style: TextStyle(fontSize: 21,))).toList()],
                    ),
                    SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      <Widget>[...itemName.map((string) => Text(string, style: TextStyle(fontSize: 21, ))).toList()],
                    )
                  ],
                ),
                //ADD MORE WIDGETS HERE
              ],
            ),
          ),
        ),
      ),
    );
  }
}
