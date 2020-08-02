import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';

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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ...items.map((item) => Text(item.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))).toList(),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Column(
                              children: items
                                  .asMap()
                                  .map(
                                    (index, item) => MapEntry(
                                      index,
                                      Increment(
                                        itemQuantity: item.amount,
                                        onChanged: (val) {
                                          setState(() {
                                            items[index].amount = val;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                  .values
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Expected Date: ${widget.donation.date}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Name: WIP", //TODO: add donor name
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Email: ${widget.donation.volunteerEmail}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21.0)),
                  color: secondaryTertiary,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => SingleActionAlert(
                              actionName: 'Confirm',
                              subtitle: 'Once you confirm, the delivered items will be removed from your requested items',
                              action: () {
                                //TODO: Make this go back to dashboard page
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              title: 'Confirm Order',
                            ));
                  },
                  child: Text('Confirm Items Delivered', style: TextStyle(fontSize: 20, color: colorScheme.onSecondary)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
