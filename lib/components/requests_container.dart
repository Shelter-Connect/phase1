import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/text_button.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/pages/organization/expected_deliveries_page.dart';

class RequestContainer extends StatelessWidget {
  final List<Item> items;
  final String deliveryId;
  final String category;

  RequestContainer({this.items, this.deliveryId, this.category});

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
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        children: [
                          Text(
                            items[index].amount.toString(),
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 5),
                          Text(
                            items[index].name,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(width: 5),
                          if (items[index].specificDescription != null)
                            Text(
                              items[index].specificDescription,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    text: 'Edit Request',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExpectedDeliveriesPage()), //TODO Replace the page with a edit page
                      );
                      //TODO: Make this button go to Expected Deliveries
                    },
                  ),
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
