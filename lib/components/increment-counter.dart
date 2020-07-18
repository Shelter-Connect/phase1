import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/organization/organization_expected_deliveries_page.dart';

class ItemIncrement extends StatefulWidget {
  final String itemName;
//  final List itemQuantity;

  ItemIncrement( {this.itemName});

  @override
  _ItemIncrementState createState() => _ItemIncrementState();
}

class _ItemIncrementState extends State<ItemIncrement> {
  int _counter = 0;


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter = max(0, _counter - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Text(widget.itemName)),
          Row(
            children: <Widget>[
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFCCCCCC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: _decrementCounter,
                  icon: Icon(Icons.remove, size: 15,),
                  tooltip: 'Decrement',
                ),
              ),
              SizedBox(width: 25),
              Text('$_counter'),
              SizedBox(width: 25),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Color(0xFF26A0FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: _incrementCounter,
                  icon: Icon(Icons.add, size: 15),
                  tooltip: 'Increment',
                ),
              ),
            ],
          ),

        ],
      );

  }
}


//Widget build(BuildContext context) {
//  return Wrap(
//    children: <Widget>[
//      Text(widget.itemName),
//      Container(
//        alignment: Alignment.centerRight,
//        color: Colors.blue,
//        child: Align(
//          alignment: Alignment.centerRight,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              IconButton(
//                onPressed: _decrementCounter,
//                icon: Icon(Icons.remove),
//                tooltip: 'Decrement',
//              ),
//              Text('$_counter'),
//              IconButton(
//                onPressed: _incrementCounter,
//                icon: Icon(Icons.add),
//                tooltip: 'Increment',
//              ),
//            ],
//          ),
//        ),
//      ),
//    ],
//  );
//}
//}