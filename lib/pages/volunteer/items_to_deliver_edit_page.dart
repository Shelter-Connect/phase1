import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/organization.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class EditDeliveryPage extends StatefulWidget {
  final Organization organization;
  final Donation donation;

  EditDeliveryPage(this.organization, this.donation);

  @override
  _EditDeliveryPageState createState() => _EditDeliveryPageState();
}

class _EditDeliveryPageState extends State<EditDeliveryPage> {
  Donation newDonation;

  @override
  void initState() {
    newDonation = widget.donation.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
        title: ' ',
        helpText: '',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Delivery to ${widget.organization.name}', style: mainTitleStyle),
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.donation.items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${widget.donation.items[index].name}',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        ItemIncrementWithText(
                                          initialQuantity: widget.donation.items[index].amount,
                                          onChanged: (val) {
                                            newDonation.items[index].amount = val;
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,)
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
                SizedBox(height: 20),
                RoundedButton(
                  title: 'Confirm Edit',
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {});//TODO: Make Edit Functionality
                  },
                )
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