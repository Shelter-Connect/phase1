import 'package:flutter/material.dart';
import 'package:phase1/components/date_time_field.dart';
import 'package:phase1/components/item_increment.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/user.dart';
import 'package:phase1/pages/volunteer/donation_confirmation_page.dart';
import 'package:provider/provider.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class VolunteerDonatePage extends StatefulWidget {
  final Organization organization;

  const VolunteerDonatePage({this.organization});

  @override
  _VolunteerDonatePageState createState() => _VolunteerDonatePageState();
}

class _VolunteerDonatePageState extends State<VolunteerDonatePage> {
  Donation donation;

  @override
  void initState() {
    donation = Donation(organizationId: widget.organization.id, volunteerId: Provider.of<User>(context, listen: false).user.uid);
    super.initState();
  }

  List<Item> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: ' ',
      helpText: 'If u don\'t know how to use this app u stupid lmao',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.organization.name,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
              ),
              Text(
                '${widget.organization.distance.toStringAsFixed(1)} miles away',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: purpleAccent),
              ),
              BasicDateTimeField(
                donation: donation,
              ),
              SizedBox(height: 20),
              ...widget.organization.requestedItems
                  .map((category, categoryItems) => MapEntry(
                      category,
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        category,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 5,
                                    width: 50,
                                    decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ...categoryItems
                                      .asMap()
                                      .map((index, item) => MapEntry(
                                          index,
                                          Column(
                                            children: [
                                              ItemIncrementWithText(
                                                itemName: item.name,
                                                maxQuantity: item.amount,
                                                onChanged: (val) {
                                                  //TODO
                                                },
                                              ),
                                              SizedBox(height: 10.0),
                                            ],
                                          )))
                                      .values
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                        ],
                      )))
                  .values
                  .toList(),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DonationConfirmationPage(widget.organization, donation)),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: purpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                    child: Text(
                      'Finalize Your Donation',
                      style: TextStyle(color: colorScheme.onSecondary, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
