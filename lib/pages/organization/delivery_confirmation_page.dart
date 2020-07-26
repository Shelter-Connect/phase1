import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/increment.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class ConfirmDeliveryPage extends StatefulWidget {
  final String dateRequested, dateExpected, donorName, donorEmail;
  final List itemQuantity;
  final List itemName;

  ConfirmDeliveryPage(
      {@required this.itemName,
      @required this.itemQuantity,
      @required this.dateRequested,
      @required this.dateExpected,
      @required this.donorName,
      @required this.donorEmail});

  @override
  _ConfirmDeliveryPageState createState() => _ConfirmDeliveryPageState(
      // TODO: add documentId parameter
      );
}

// donorName, donorEmail, itemName, itemQuantity, dateRequested, dateExpected

class _ConfirmDeliveryPageState extends State<ConfirmDeliveryPage> {
  List<int> itemQuantity;

  @override
  void initState() {
    setState(() {
      itemQuantity = widget.itemQuantity;
    });
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
                decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Amount Received',
                        style: TextStyle(
                          fontSize: 24,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ...widget.itemName.map((string) => Text(string, style: TextStyle(fontSize: 20))).toList(),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Column(
                              children: itemQuantity
                                  .asMap()
                                  .map(
                                    (index, quantity) => MapEntry(
                                      index,
                                      Increment(
                                        itemQuantity: quantity,
                                        onChanged: (val) {
                                          setState(() {
                                            itemQuantity[index] = val;
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
                            "Expected Date: ${widget.dateExpected}",
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
                            "Date Requested: ${widget.dateRequested}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Name: ${widget.donorName}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Email: ${widget.donorEmail}",
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
                    print(itemQuantity);
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
