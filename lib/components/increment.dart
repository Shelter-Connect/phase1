import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:phase1/constants.dart';

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
          HoldDetector(
            onHold: _decrementCounter,
            holdTimeout: Duration(milliseconds: 150),
            enableHapticFeedback: true,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: lightGrey,
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
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            ),
          ),
          HoldDetector(
            onHold: _incrementCounter,
            holdTimeout: Duration(milliseconds: 150),
            enableHapticFeedback: true,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: _incrementCounter,
                color: colorScheme.onSecondary,
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
  bool isSnackBarActive = false;
  TextEditingController controller = TextEditingController();

  void initState() {
    _counter = 0;
    controller.text = _counter.toString();
    super.initState();
  }

  void _incrementCounter() {
    if (_counter == widget.maxQuantity) {
      if (isSnackBarActive == false) {
        setState(() {
          isSnackBarActive = true;
        });

        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('You have reached the maximum amount of items this shelter is requesting.')))
            .closed
            .then((SnackBarClosedReason reason) {
          setState(() {
            isSnackBarActive = false;
          });
        });
      }
    }
    setState(() {
      _counter = min(_counter + 1, widget.maxQuantity);
    });
    widget.onChanged(_counter);
    controller.text = (_counter).toString();
  }

  void _decrementCounter() {
    setState(() {
      _counter = max(0, _counter - 1);
    });
    widget.onChanged(_counter);
    controller.text = _counter.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text(widget.itemName),
        ),
        Row(
          children: <Widget>[
            HoldDetector(
              onHold: _decrementCounter,
              holdTimeout: Duration(milliseconds: 150),
              enableHapticFeedback: true,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: lightGrey,
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
            ),
            SizedBox(width: 25),
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
                inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(width: 25),
            HoldDetector(
              onHold: _incrementCounter,
              holdTimeout: Duration(milliseconds: 150),
              enableHapticFeedback: true,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: _incrementCounter,
                  color: colorScheme.onSecondary,
                  icon: Icon(Icons.add, size: 15),
                  tooltip: 'Increment',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ItemIncrementCreateRequest extends StatefulWidget {
  final String itemName;
  final int maxQuantity;
  final Function(int) onChanged;

  ItemIncrementCreateRequest({this.itemName, this.maxQuantity, this.onChanged});

  @override
  _ItemIncrementCreateRequestState createState() => _ItemIncrementCreateRequestState();
}

class _ItemIncrementCreateRequestState extends State<ItemIncrementCreateRequest> {
  int _counter = 0;
  TextEditingController controller = TextEditingController(text: '0');

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    widget.onChanged(_counter);
    controller.text = (_counter).toString();
  }

  void _decrementCounter() {
    setState(() {
      _counter = max(0, _counter - 1);
    });
    widget.onChanged(_counter);
    controller.text = _counter.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            HoldDetector(
              onHold: _decrementCounter,
              holdTimeout: Duration(milliseconds: 150),
              enableHapticFeedback: true,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
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
            ),
            SizedBox(width: 25),
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
                inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(width: 25),
            HoldDetector(
              onHold: _incrementCounter,
              holdTimeout: Duration(milliseconds: 150),
              enableHapticFeedback: true,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: _incrementCounter,
                  color: Colors.white,
                  icon: Icon(Icons.add, size: 15),
                  tooltip: 'Increment',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
