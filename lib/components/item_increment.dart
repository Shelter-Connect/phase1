import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

class ItemIncrementWithText extends StatefulWidget {
  final String itemName;
  final int maxQuantity;
  final Function(int) onChanged;

  ItemIncrementWithText({this.itemName, this.maxQuantity, this.onChanged});

  @override
  _ItemIncrementWithTextState createState() => _ItemIncrementWithTextState();
}

class _ItemIncrementWithTextState extends State<ItemIncrementWithText> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = min(_counter+1, widget.maxQuantity);
    });
    widget.onChanged(_counter);
  }

  void _decrementCounter() {
    setState(() {
      _counter = max(0, _counter - 1);
    });
    widget.onChanged(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(child: Text(widget.itemName, style: TextStyle(fontSize: 17.0))),
        Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: whiteBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: _decrementCounter,
                icon: Icon(
                  Icons.remove,
                  size: 15,
                ),
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
                color: blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: _incrementCounter,
                icon: Icon(Icons.add, size: 15, color: colorScheme.onSecondary),
                tooltip: 'Increment',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ItemIncrementWithoutText extends StatefulWidget {
  @override
  _ItemIncrementWithoutTextState createState() => _ItemIncrementWithoutTextState();
}

class _ItemIncrementWithoutTextState extends State<ItemIncrementWithoutText> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _counter = max(0, _counter - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: _decrementCounter,
                icon: Icon(
                  Icons.remove,
                  size: 15,
                ),
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
                color: colorScheme.onSecondary,
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
