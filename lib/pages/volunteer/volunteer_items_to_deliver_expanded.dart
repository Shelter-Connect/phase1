import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

import '../../components/standard_layout.dart';
import 'volunteer_items_to_deliver_page.dart';

class ItemsToDeliverExpanded extends StatefulWidget {
  @override
  _ItemsToDeliverExpandedState createState() => _ItemsToDeliverExpandedState();
}

class _ItemsToDeliverExpandedState extends State<ItemsToDeliverExpanded> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
        title: ' ',
        helpText: 'If u don\'t know how to use this app u stupid lmao',
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Text(
                  'Items to Deliver for (Organization Name)',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Text(
                  'Distance: (Distance away)',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: purpleAccent),
                ),
              ),
              SizedBox(height: 20),
              FlatButton(
                  onPressed: () {
                    //TODO
                  },
                  child: Container(
                    decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Selected Donations'),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FlatButton(
                              color: colorScheme.error,
                              onPressed: () {},
                              child: Container(child: Text('Edit Donations')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ItemsToDeliver('Blankets', 4),
                          SizedBox(
                            height: 2.5,
                          ),
                          ItemsToDeliver('Bananas', 15),
                          SizedBox(
                            height: 2.5,
                          ),
                          ItemsToDeliver('Can of Beans', 10),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
