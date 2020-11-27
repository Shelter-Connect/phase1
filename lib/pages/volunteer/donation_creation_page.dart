import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/date_time_field.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/user.dart';
import 'package:phase1/pages/volunteer/donation_confirmation_page.dart';
import 'package:provider/provider.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class DonationCreationPage extends StatefulWidget {
  final Organization organization;

  const DonationCreationPage({@required this.organization});

  @override
  _DonationCreationPageState createState() => _DonationCreationPageState();
}

class _DonationCreationPageState extends State<DonationCreationPage> {
  Donation donation = Donation();
  final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    donation = Donation(
      volunteerId: Provider.of<User>(context, listen: false).user.uid,
      volunteerEmail: Provider.of<User>(context, listen: false).user.email,
      organization: Organization(
        id: widget.organization.id,
        name: widget.organization.name,
        description: widget.organization.description,
        email: widget.organization.email,
        address: widget.organization.address,
        location: widget.organization.location,
      ),
    );
    donation.items = [];
    super.initState();
  }

  List<Item> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: ' ',
      helpText: 'To make a donation, enter a date when you can deliver the items, and choose the amount of items you can deliver. ',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.organization.name,
                    style: mainTitleStyle,
                  ),
                  if (widget.organization.distance != null)
                    Text('${widget.organization.distance.toStringAsFixed(1)} miles away', style: subTitleStyle),
                ],
              ),
            ),
            GreyLine(),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xFFF5F5F5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
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
                        onChanged: (val) {
                          setState(() {
                            donation.date = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SmallGreyLine(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Center(
                child: Text(
                  '*All Items can be slightly used unless explicitly stated by the organization',
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 10),
            SmallGreyLine(),
            SizedBox(height: 5),
            ...widget.organization.requestedItems
                .map(
                  (category, categoryItems) => MapEntry(
                    category,
                    Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 5,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: purpleAccent,
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ...categoryItems
                                    .asMap()
                                    .map(
                                      (index, item) => MapEntry(
                                        index,
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 3.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 5.0),
                                                      child: Row(
                                                        children: [
                                                          if (item.amount > 0)
                                                            Expanded(
                                                              child: Text(
                                                                '${item.name} - ${item.amount} ${item.unit ?? ''}'.trim(),
                                                                style: TextStyle(
                                                                  fontSize: 17.0,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            ),
                                                          if (item.amount > 0) SizedBox(width: 5),
                                                          if (item.amount > 0)
                                                            Container(
                                                              height: 12,
                                                              width: 12,
                                                              decoration:
                                                                  BoxDecoration(color: item.urgencyColor, borderRadius: BorderRadius.circular(40)),
                                                            ),
                                                          if (item.amount > 0) SizedBox(width: 15),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ItemIncrementWithText(
                                                    itemName: item.name,
                                                    initialQuantity: 0,
                                                    maxQuantity: item.amount,
                                                    onChanged: (val) {
                                                      Item currentItem = item.clone();
                                                      currentItem.amount = val;
                                                      donation.items.removeWhere((prevItem) =>
                                                          prevItem.name == currentItem.name &&
                                                          prevItem.category == currentItem.category &&
                                                          prevItem.specificDescription == currentItem.specificDescription &&
                                                          prevItem.unit == currentItem.unit);
                                                      if (currentItem.amount != 0) donation.items.add(currentItem);
                                                    },
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
                                              if (item.specificDescription != null)
                                                Text(
                                                  item.specificDescription,
                                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .values
                                    .toList(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        SmallestGreyLine(),
                      ],
                    ),
                  ),
                )
                .values
                .toList(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    if (donation.items.length == 0) {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Please select at least one item to donate'),
                      );
                    } else if (donation.date == null) {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Please enter the expected delivery date of the donation'),
                      );
                    } else if (donation.date.isBefore(today)) {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'The expected delivery date cannot be before today'),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonationConfirmationPage(widget.organization, donation),
                        ),
                      );
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: purpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                    child: Text(
                      'Finalize Donation',
                      style: TextStyle(color: colorScheme.onSecondary, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
