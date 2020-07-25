import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/models/organization.dart';

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
    return StandardLayout(
      title: ' ',
      helpText: 'If u don\'t know how to use this app u stupid lmao',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Confirm Your Delivery to:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: purpleAccent),
                  ),
                  Text(
                    widget.organization.name,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Text(
                /*'on: ${DateFormat.yMMMd().add_jm().format(widget.donation.date)}',*/
                'on: ${DateFormat.yMMMd().format(widget.donation.date)}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: purpleAccent),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(color: colorScheme.background, borderRadius: BorderRadius.all(Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
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
                        Container(
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: widget.donation.items
                              .map((String category, List<Item> items) => MapEntry(
                                  category,
                                  Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                    SizedBox(height: 10.0),
                                    Text(
                                      category,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                      ),
                                    ),
                                    ...items
                                        .map(
                                          (item) => Padding(
                                            padding: const EdgeInsets.only(top: 3.0),
                                            child: Text(
                                              '${item.name} x ${item.amount}',
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ])))
                              .values
                              .toList(),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(color: colorScheme.background, borderRadius: BorderRadius.all(Radius.circular(20))),
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
                            decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
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
                ),
              ],
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    //TODO Update Firebase and input new order
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: purpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                    child: Text(
                      'Confirm Your Delivery',
                      style: TextStyle(color: colorScheme.onSecondary, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10)
          ],
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
            text: TextSpan(children: <TextSpan>[
              TextSpan(text: 'Email Address: ', style: TextStyle(fontSize: 17, color: colorScheme.onBackground)),
              TextSpan(text: orgEmail, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: colorScheme.onBackground))
            ]),
          ),
        if (orgEmail != null)
          SizedBox(
            height: 10,
          ),
        if (orgNumber != null)
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(text: 'Phone Number: ', style: TextStyle(fontSize: 17, color: colorScheme.onBackground)),
              TextSpan(text: orgNumber, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: colorScheme.onBackground))
            ]),
          ),
        if (orgNumber != null) SizedBox(height: 10),
        if (orgAddress != null)
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(text: 'Donation Location: ', style: TextStyle(fontSize: 17, color: colorScheme.onBackground)),
              TextSpan(text: orgAddress, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: colorScheme.onBackground))
            ]),
          ),
        SizedBox(height: 10),
      ],
    );
  }
}
