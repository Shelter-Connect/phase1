import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/date_time_field.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/services/firestore_helper.dart';

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
                  donation: widget.donation,
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
                              decoration: BoxDecoration(
                                color: purpleAccent,
                                borderRadius: BorderRadius.circular(21),
                              ),
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
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${widget.donation.items[index].name} - ${widget.donation.items[index].amount} ${widget.donation.items[index].unit ?? ''}'
                                                    .trim(),
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              if (widget.donation.items[index].specificDescription != null)
                                                Text(
                                                  widget.donation.items[index].specificDescription,
                                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                                ),
                                            ],
                                          ),
                                        ),
                                        ItemIncrementWithText(
                                          initialQuantity: widget.donation.items[index].amount,
                                          maxQuantity: widget.organization.requestedItems[widget.donation.items[index].category]
                                                  .singleWhere((item) =>
                                                      (item.name == widget.donation.items[index].name) &&
                                                      (item.specificDescription == widget.donation.items[index].specificDescription) &&
                                                      (item.unit == widget.donation.items[index].unit))
                                                  .amount +
                                              widget.donation.items[index].amount,
                                          onChanged: (val) {
                                            newDonation.items[index].amount = val;
                                          },
                                        ),
                                        IconButton(icon: Icon(Icons.cancel), onPressed: () {  },
                                            //TODO: Make it cancel
                                          color: colorScheme.error
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              },
                            ),
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
                    setState(() {
                      if ((newDonation.date.isBefore(DateTime.now())) || (newDonation.date.day == DateTime.now().day))
                        showDialog(
                          context: context,
                          builder: (_) => NoActionAlert(title: 'Please choose a date that has not passed'),
                        );
                      Navigator.pop(context);
                      Navigator.pop(context);
                      List<Item> delta = List();
                      for (Item newItem in newDonation.items) {
                        Item item = newItem.clone();
                        item.amount *= -1;
                        delta.add(item);
                      }
                      FirestoreHelper.cancelVolunteerDelivery(context, widget.donation);
                      FirestoreHelper.updateRequests(context: context, items: delta, organizationId: widget.donation.organization.id);
                      FirestoreHelper.createDonation(context, newDonation);
                    });
                  },
                )
              ],
            ),
          ),
        ));
  }
}

class OrganizationInformation extends StatefulWidget {
  final String orgEmail;
  final String orgAddress;
  final DateTime dateTime;
  final Donation donation;

  OrganizationInformation({@required this.orgEmail, @required this.orgAddress, @required this.dateTime, this.donation});

  @override
  _OrganizationInformationState createState() => _OrganizationInformationState();
}

class _OrganizationInformationState extends State<OrganizationInformation> {
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
                            text: widget.orgEmail,
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
                            text: widget.orgAddress,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BasicDateField(
                      onChanged: (val) {
                        setState(() {
                          widget.donation.date = val;
                        });
                      },
                      initialValue: widget.dateTime,
                      labelText: 'Edit Date',
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
