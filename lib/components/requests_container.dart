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
    return Column(
      children: [
        Card(
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
                            if (items[index].amount > 0)
                              Row(
                                children: [
                                  Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${items[index].name} - ${items[index].amount.toString()} ${items[index].unit ?? ''}'.trim(),
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                'Request Completed!',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.green,
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
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
