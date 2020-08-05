import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/colored_button.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class ConfirmDeliveryPage extends StatefulWidget {
  final Donation donation;

  ConfirmDeliveryPage({this.donation});

  @override
  _ConfirmDeliveryPageState createState() => _ConfirmDeliveryPageState();
}

class _ConfirmDeliveryPageState extends State<ConfirmDeliveryPage> {
  List<Item> items;

  @override
  void initState() {
    items = [];
    for (Item item in widget.donation.items) {
      items.add(Item.clone(item));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: clean, clean, clean, clean, clean, and clean again
    return StandardLayout(
      title: "Confirm Delivery",
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: elevatedBoxStyle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text(
                        'Amount Received',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
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
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ...items.map((item) => Padding(padding: EdgeInsets.all(10),
                                      child: Center(child: Text(item.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))))).toList(),
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: items
                                      .asMap()
                                      .map(
                                        (index, item) => MapEntry(
                                          index,
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Increment(
                                              itemQuantity: item.amount,
                                              onChanged: (val) {
                                                setState(() {
                                                  items[index].amount = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                      .values
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ColoredButton(
                color: purpleAccent,
                text: 'Confirm Items Delivered',
                onPressed: () {
                  FirestoreHelper.confirmDelivery(context, widget.donation);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
