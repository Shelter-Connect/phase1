import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemIncrement extends StatefulWidget {
  final String itemName;

  ItemIncrement({this.itemName});

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
      _counter--;
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
              IconButton(
                onPressed: _decrementCounter,
                icon: Icon(Icons.remove),
                tooltip: 'Decrement',
              ),
              Text('$_counter'),
              IconButton(
                onPressed: _incrementCounter,
                icon: Icon(Icons.add),
                tooltip: 'Increment',
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