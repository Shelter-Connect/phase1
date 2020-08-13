import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';

class RequestContainer extends StatelessWidget {
  final List<Item> items;
  final String deliveryId;
  final String category;

  RequestContainer({this.items, this.deliveryId, this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${items[index].name} - ${items[index].amount.toString()} ${items[index].unit ?? ''}'.trim(),
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          if (items[index].specificDescription != null)
                            Text(
                              items[index].specificDescription,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          //TODO: Implement Item Units
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
