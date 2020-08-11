import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phase1/components/colored_button.dart';
import 'package:phase1/models/donation.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';
import 'delivery_confirmation_page.dart';

class DeliveryInformationPage extends StatefulWidget {
  final Donation donation;

  DeliveryInformationPage({this.donation});

  @override
  _DeliveryInformationPageState createState() => _DeliveryInformationPageState();
}

class _DeliveryInformationPageState extends State<DeliveryInformationPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: clean, clean, clean, clean, clean, and clean again
    return StandardLayout(
      title: "Delivery Information",
      helpText: 'This page shows information about a specific delivery. If this delivery has been received, press the Confirm Delivery button.',
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: elevatedBoxStyle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        'Items to be Delivered',
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
                        padding: const EdgeInsets.all(10.0),
                        itemCount: widget.donation.items.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.donation.items[index].name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                                  Text('${widget.donation.items[index].amount.toString()}' '${widget.donation.items[index].unit ?? ''}'.trim(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))
                                ],
                              ),
                              if (widget.donation.items[index].specificDescription != null)
                                Text(
                                  widget.donation.items[index].specificDescription,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 5),
                      Container(
                        //THIS IS THE LINE
                        height: 3,
                        decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(20)),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Expected Date: ${(DateFormat('yMMMMd').format(widget.donation.date))}',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Name: ${widget.donation.volunteerName}",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Email: ${widget.donation.volunteerEmail}",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
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
              child: ColoredButton(
                color: purpleAccent,
                text: 'Confirm Delivery',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmDeliveryPage(
                        donation: widget.donation,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
