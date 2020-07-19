import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


//class Increment extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: new ListView(
//        children: new List.generate(5, (i)=>new ListTileItem(
//          title: "Item#$i",
//        )),
//      ),
//    );
//  }
//}
//class ListTileItem extends StatefulWidget {
//  String title;
//  List itemQuantity;
//  ListTileItem({this.title, this.itemQuantity});
//  @override
//  _ListTileItemState createState() => new _ListTileItemState();
//}
//
//class _ListTileItemState extends State<ListTileItem> {
//  List _itemCount = widget.itemQuantity;
//  @override
//  Widget build(BuildContext context) {
//    return new ListTile(
//      title: new Text(widget.title),
//      trailing: new Row(
//        children: <Widget>[
//          _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
//          new Text(_itemCount.toString()),
//          new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
//        ],
//      ),
//    );
//  }
//}






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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(_counter.toString(), style: TextStyle(fontSize: 20)),
          ),
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


