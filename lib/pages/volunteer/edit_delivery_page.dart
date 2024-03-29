import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/date_time_field.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/models/donation.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class EditDeliveryPage extends StatefulWidget {
  final Donation donation;

  EditDeliveryPage(this.donation);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Delivery to ${widget.donation.organization.name}', style: mainTitleStyle),
              ),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expected Delivery Date',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      BasicDateField(
                        initialValue: widget.donation.date,
                        onChanged: (val) {
                          setState(() {
                            newDonation.date = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
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
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
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
                                                SizedBox(width: 5),
                                                Container(
                                                  height: 12,
                                                  width: 12,
                                                  decoration: BoxDecoration(
                                                      color: widget.donation.items[index].urgencyColor, borderRadius: BorderRadius.circular(40)),
                                                ),
                                                SizedBox(width: 15),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (widget.donation.organization.requestedItems[widget.donation.items[index].category] != null)
                                        ItemIncrementWithText(
                                          initialQuantity: widget.donation.items[index].amount,
                                          maxQuantity: widget.donation.organization.requestedItems[widget.donation.items[index].category]
                                                  .singleWhere((item) =>
                                                      (item.name == widget.donation.items[index].name) &&
                                                      (item.specificDescription == widget.donation.items[index].specificDescription) &&
                                                      (item.unit == widget.donation.items[index].unit))
                                                  .amount +
                                              widget.donation.items[index].amount,
                                          onChanged: (val) {
                                            newDonation.items[index].amount = val;
                                          },
                                        )
                                      else
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${widget.donation.organization.name} has cancelled their request for ${widget.donation.items[index].name}, so you may not edit it at this time (You can still deliver it).',
                                                style: TextStyle(fontSize: 14, color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: RoundedButton(
                  title: 'Confirm Edit',
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      if ((newDonation.date.isBefore(DateTime.now())))
                        showDialog(
                          context: context,
                          builder: (_) => NoActionAlert(title: 'Please choose a date that has not passed'),
                        );
                      else {
                        Navigator.pop(context, newDonation);
                        FlushBar(
                          message: 'Your donation has been edited',
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.all(0),
                        ).build(context);
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ));
  }
}
