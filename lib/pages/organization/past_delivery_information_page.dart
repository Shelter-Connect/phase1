import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phase1/models/past_donation.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class PastDeliveryInformationPage extends StatefulWidget {
  final PastDonation donation;

  PastDeliveryInformationPage({this.donation});

  @override
  _PastDeliveryInformationPageState createState() =>
      _PastDeliveryInformationPageState();
}

class _PastDeliveryInformationPageState
    extends State<PastDeliveryInformationPage> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: 'Delivery Information',
      helpText: 'This page shows information about a completed delivery. You can see the items deliveries, amount of each item, and a specific description. '
          'Additionally, you can see the date received, the name of the donor, and their email.',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        'Delivered Items',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 5,
                        width: 140,
                        decoration: BoxDecoration(
                            color: purpleAccent,
                            borderRadius: BorderRadius.circular(21)),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10.0),
                        itemCount: widget.donation.items.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(children: [
                                          Text(
                                              '${widget.donation.items[index].name} - ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400)),
                                          Text(
                                              '${widget.donation.items[index].amount} ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400)),
                                          Text(
                                              '${widget.donation.items[index].unit ?? ''}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400)),
                                        ]),
                                        if (widget.donation.items[index]
                                                .specificDescription !=
                                            null)
                                          Text(
                                            widget.donation.items[index]
                                                .specificDescription,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 3,
                        decoration: BoxDecoration(
                            color: purpleAccent,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Date Received: ${(DateFormat('yMMMMd').format(widget.donation.date))}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Name: ${widget.donation.volunteerName}",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Email: ${widget.donation.volunteerEmail}",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
