import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';
import 'items_to_deliver_edit_page.dart';

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
      helpText: 'This page shows a delivery you have signed up for. Here, you can edit or cancel this delivery. ',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Selected Donations',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => EditDeliveryPage(widget.donation.organization, widget.donation)));
                                },
                              ),
                            ],
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
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.donation.items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      '${widget.donation.items[index].name} - ${widget.donation.items[index].amount} ${widget.donation.items[index].unit ?? ''}'
                                          .trim(),
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  if (widget.donation.items[index].specificDescription != null)
                                    Text(
                                      widget.donation.items[index].specificDescription,
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                  SizedBox(
                                    height: 5,
                                  )
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
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => SingleActionAlert(
                      action: () {
                        FirestoreHelper.cancelVolunteerDelivery(context, widget.donation);
                        Navigator.pop(context);
                      },
                      actionName: 'Cancel Delivery',
                      title: 'Cancel Delivery?',
                      subtitle: 'You cannot revert this action',
                      //TODO: cancel delivery
                    ),
                  );
                },
                child: Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: colorScheme.error,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.cancel, color: Colors.white, size: 28),
                        SizedBox(width: 5),
                        Text(
                          'Cancel Delivery',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        //TODO: cancel delivery
                      ],
                    ),
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
                  decoration: BoxDecoration(
                    color: purpleAccent,
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Email Address: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: orgEmail,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Donation Location: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: orgAddress,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Deliver By: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '${DateFormat('MMMMd').format(dateTime)}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
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
