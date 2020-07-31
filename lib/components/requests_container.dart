import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

class RequestContainer extends StatelessWidget {
  final List itemName, itemQuantity;
  final String deliveryId;
  final String category;

  RequestContainer({this.itemName, this.itemQuantity, this.deliveryId, this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
     borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: elevatedBoxStyle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  '$category',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          ...itemQuantity
                              .map(
                                (int) => Text(
                                  '$int',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ...itemName
                            .map((string) => Text(string,
                                style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400,
                                )))
                            .toList()
                      ],
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
