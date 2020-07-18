import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Increment extends StatefulWidget {
final int itemQuantity;

//  Increment(itemQuantity);
  Increment({this.itemQuantity});
  @override
  _ItemIncrementState createState() => _ItemIncrementState();
}

class _ItemIncrementState extends State<Increment> {
  int _counter;
  @override
  void initState() {
    _counter = widget.itemQuantity ?? 0;
    super.initState();
  }



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
          Text(_counter.toString()),
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
      );

  }
}


