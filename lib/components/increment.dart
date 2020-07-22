import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Increment extends StatefulWidget {
  final int itemQuantity;
  final Function onChanged;

  Increment({this.itemQuantity, this.onChanged});

  @override
  _ItemIncrementState createState() => _ItemIncrementState();
}

class _ItemIncrementState extends State<Increment> {
  int _counter;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _counter = widget.itemQuantity ?? 0;
    controller.text = _counter.toString();
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      controller.text = (++_counter).toString();
      widget.onChanged(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter = max(0, _counter - 1);
      controller.text = _counter.toString();
      widget.onChanged(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
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
          Container(
            width: 50,
            height: 23,
            padding: EdgeInsets.only(left: 15),
            child: TextField(
              textAlign: TextAlign.center,
              controller: controller,
              onChanged: (val) {
                _counter = int.parse(val);
                widget.onChanged(_counter);
              },
              style: TextStyle(fontSize: 17),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                counterText: "",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child:
            Container(
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
      ),
    );
  }
}
