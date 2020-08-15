import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class DonationConfirmationPage extends StatefulWidget {
  final Organization organization;
  final Donation donation;

  DonationConfirmationPage(this.organization, this.donation);

  @override
  _DonationConfirmationPageState createState() => _DonationConfirmationPageState();
}

class _DonationConfirmationPageState extends State<DonationConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    widget.donation.items.sort((a, b) => a.category.compareTo(b.category));

    return StandardLayout(
      title: ' ',
      helpText: 'Make sure to check the donation address, date, and items before confirming your donation! ',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Confirm Your Delivery to:', style: subTitleStyle),
                  Text(widget.organization.name, style: mainTitleStyle),
                ],
              ),
              Text(
                /*'on: ${DateFormat.yMMMd().add_jm().format(widget.donation.date)}',*/
                'on: ${DateFormat.yMMMd().format(widget.donation.date)}',
                style: subTitleStyle,
              ),
              SizedBox(height: 20),
              Column(
                children: <Widget>[
                  Container(
                    decoration: elevatedBoxStyle,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Organization Information ',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 5,
                            width: 100,
                            decoration: BoxDecoration(
                              color: purpleAccent,
                              borderRadius: BorderRadius.circular(21),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InfoText(
                              orgEmail: widget.organization.email, orgNumber: widget.organization.number, orgAddress: widget.organization.address),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                decoration: elevatedBoxStyle,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Selected Donations',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 5,
                            width: 100,
                            decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: widget.donation.items
                                .asMap()
                                .map((index, item) {
                                  return MapEntry(
                                    index,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(height: 10.0),
                                        if (index == 0 || item.category != widget.donation.items[index - 1].category)
                                          Text(
                                            item.category,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23.0,
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: Text(
                                                  '${item.name} - ${item.amount} ${item.unit ?? ''}'.trim(),
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (item.specificDescription != null)
                                          Text(
                                            item.specificDescription,
                                            style: TextStyle(fontSize: 14, color: Colors.grey),
                                          ),
                                      ],
                                    ),
                                  );
                                })
                                .values
                                .toList(),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/volunteer_bottom_navigation'));
                    List<Item> delta = List();
                    for (Item newItem in widget.donation.items) {
                      Item item = newItem.clone();
                      item.amount *= -1;
                      delta.add(item);
                    }
                    FirestoreHelper.updateRequests(context: context, items: delta, organizationId: widget.donation.organization.id);
                    FirestoreHelper.createDonation(context, widget.donation);
                    FlushBar(title: 'Donation Received', message: 'Go to the Delivery page to see delivery information', duration: Duration(seconds: 3)).build(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: purpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                    child: Text(
                      'Confirm Donation',
                      style: TextStyle(color: colorScheme.onSecondary, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  final String orgEmail;
  final String orgNumber;
  final String orgAddress;

  InfoText({this.orgEmail, this.orgNumber, this.orgAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (orgEmail != null)
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Email Address: ', style: TextStyle(fontSize: 17, color: colorScheme.onBackground)),
                TextSpan(text: orgEmail, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: colorScheme.onBackground))
              ],
            ),
          ),
        if (orgEmail != null)
          SizedBox(
            height: 10,
          ),
        if (orgNumber != null)
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Phone Number: ', style: TextStyle(fontSize: 17, color: colorScheme.onBackground)),
                TextSpan(text: orgNumber, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: colorScheme.onBackground))
              ],
            ),
          ),
        if (orgNumber != null) SizedBox(height: 10),
        if (orgAddress != null)
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Donation Location: ', style: TextStyle(fontSize: 17, color: colorScheme.onBackground)),
                TextSpan(text: orgAddress, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: colorScheme.onBackground))
              ],
            ),
          ),
        SizedBox(height: 10),
      ],
    );
  }
}
