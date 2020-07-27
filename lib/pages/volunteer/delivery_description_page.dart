import 'package:flutter/material.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/organization.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class DeliveryDescriptionPage extends StatefulWidget {
  final Organization organization;
  Donation donation;

  DeliveryDescriptionPage(this.organization, this.donation);
  @override
  _DeliveryDescriptionPageState createState() =>
      _DeliveryDescriptionPageState();
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
                  'Items to Deliver to ${widget.organization.name}',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: purpleAccent),
                ),
                Text(
                  'Distance: ${widget.organization.distance.toStringAsFixed(1)}',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: purpleAccent),
                ),
                SizedBox(height: 20),
                OrganizationInformation(
                    orgEmail: widget.organization.email,
                    orgPhone: widget.organization.number,
                    orgAddress: widget.organization.address),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: colorScheme.background,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8.0),
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
                              decoration: BoxDecoration(
                                  color: purpleAccent,
                                  borderRadius: BorderRadius.circular(21)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Blankets x4'),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text('Bananas x15'),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text('Can of Beans x10'),
                            SizedBox(
                              height: 10,
                            ),
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

  final String orgPhone;

  final String orgAddress;

  OrganizationInformation(
      {@required this.orgEmail,
      @required this.orgPhone,
      @required this.orgAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: colorScheme.background,
              borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  height: 10,
                ),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                      color: purpleAccent,
                      borderRadius: BorderRadius.circular(21)),
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
                              fontSize: 18,
                              color: colorScheme.onBackground,
                            )),
                        TextSpan(
                            text: orgEmail,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onBackground,
                            ))
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Phone Number: ',
                            style: TextStyle(
                              fontSize: 18,
                              color: colorScheme.onBackground,
                            )),
                        TextSpan(
                            text: orgPhone,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onBackground,
                            ))
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Donation Location: ',
                            style: TextStyle(
                              fontSize: 18,
                              color: colorScheme.onBackground,
                            )),
                        TextSpan(
                            text: orgAddress,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onBackground,
                            ))
                      ]),
                    ),
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
