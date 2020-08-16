import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/colored_button.dart';
import 'package:phase1/components/flushbar.dart';
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
      items.add(item.clone());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: "Confirm Delivery",
      helpText: 'If not all items have been delivered, enter the amount received and press the Confirm Items Delivered button.',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Amount Received',
                style: TextStyle(fontSize: 35, color: purpleAccent, fontWeight: FontWeight.w900),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(color: Color(0xFFDEDEDE), blurRadius: 5.0, spreadRadius: 1),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              ...items
                                  .map(
                                    (item) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${item.name}',
                                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '${item.unit}',
                                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                                            ),
                                            if (item.specificDescription != null)
                                              Text(
                                                item.specificDescription,
                                                style: TextStyle(fontSize: 14, color: Colors.grey),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                          Column(
                            children: items
                                .asMap()
                                .map(
                                  (index, item) => MapEntry(
                                    index,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Column(
                                        children: <Widget>[
                                          ItemIncrementWithText(
                                            initialQuantity: item.amount,
                                            onChanged: (val) {
                                              setState(() {
                                                items[index].amount = val;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                          )
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
                  List<Item> delta = List();
                  for (Item deliveredItem in items) {
                    for (Item oldItem in widget.donation.items) {
                      if ((deliveredItem.specificDescription == oldItem.specificDescription) &&
                          (deliveredItem.name == oldItem.name) &&
                          (deliveredItem.category == oldItem.category)) {
                        Item item = oldItem.clone();
                        item.amount -= deliveredItem.amount;
                        delta.add(item);
                        break;
                      }
                    }
                  }
                  FirestoreHelper.updateRequests(context: context, items: delta);
                  widget.donation.items = items;
                  FirestoreHelper.confirmDelivery(context, widget.donation);
                  Navigator.popUntil(context, ModalRoute.withName('/organization_bottom_navigation'));
                  FlushBar(message: 'Items have been Confirmed. Thank you for using Linkare!', duration: Duration(seconds: 3)).build(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
