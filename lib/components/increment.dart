import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Increment extends StatefulWidget {
  final int itemQuantity;

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
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            height: 17,
            width: 17,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Color(0xFFCCCCCC),
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: _decrementCounter,
              icon: Icon(
                Icons.remove,
                size: 15,
              ),
              tooltip: 'Decrement',
            ),
          ),
        ),
        Container(
          width: 30,
          height: 22,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4, bottom: 4, top: 4),
            child: TextField(
              maxLength: 2,
                style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                counterText: "",
    contentPadding: EdgeInsets.only(top: 200, bottom: 3,),
hintText: _counter.toString(),
    ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],

            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            height: 17,
            width: 17,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Color(0xFF26A0FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: _incrementCounter,
              icon: Icon(Icons.add, size: 15),
              tooltip: 'Increment',
            ),
          ),
        ),
      ],
    );
  }
}
