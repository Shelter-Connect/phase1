import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/organization.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class DeliveryDescriptionPage extends StatefulWidget {
  final Organization organization;
  final Donation donation;

  DeliveryDescriptionPage(this.organization, this.donation);

  @override
  _DeliveryDescriptionPageState createState() => _DeliveryDescriptionPageState();
}

class _DeliveryDescriptionPageState extends State<DeliveryDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
        title: ' ',
        helpText: 'If u don\'t know how to use this app u stupid lmao',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Delivery to ${widget.organization.name}',
                  style: mainTitleStyle
                ),
                SizedBox(height: 20),
                OrganizationInformation(
                  orgEmail: widget.organization.email,
                  orgAddress: widget.organization.address,
                  dateTime: widget.donation.date,
                ),
                SizedBox(height: 20),
                Container(
                  decoration: elevatedBoxStyle,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Selected Donations',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                FlatButton(
                                  padding: EdgeInsets.all(0.0),
                                  splashColor: transparent,
                                  highlightColor: transparent,
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: colorScheme.error,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    //TODO: Navigator.push(context, MaterialPageRoute(builder: (context) => DonationCreationPage()));
                                  },
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
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.donation.items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        '${widget.donation.items[index].name} x ${widget.donation.items[index].amount}',
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Divider(color: Colors.grey, thickness: 2,)
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 5)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class OrganizationInformation extends StatelessWidget {
  final String orgEmail;
  final String orgAddress;
  final DateTime dateTime;

  OrganizationInformation({@required this.orgEmail, @required this.orgAddress, @required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: elevatedBoxStyle,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  'Organization Information ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Email Address: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            )),
                        TextSpan(
                            text: orgEmail,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ))
                      ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Donation Location: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            )),
                        TextSpan(
                            text: orgAddress,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ))
                      ]),
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Deliver By: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            )),
                        TextSpan(
                            text: '${DateFormat('MMMMd').format(dateTime)}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ))
                      ]),
                    ),
                    SizedBox(height: 5)
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
