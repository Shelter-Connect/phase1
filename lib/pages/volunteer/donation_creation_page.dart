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
      helpText: 'If u don\'t know how to use this app u stupid lmao',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.organization.name,
                style: mainTitleStyle,
              ),
              Text('${widget.organization.distance.toStringAsFixed(1)} miles away', style: subTitleStyle),
              SizedBox(height: 20.0),
              Container(
                decoration: elevatedBoxStyle,
                padding: const EdgeInsets.all(20.0),
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
              SizedBox(height: 20),
              ...widget.organization.requestedItems
                  .map((category, categoryItems) => MapEntry(
                      category,
                      Column(
                        children: [
                          Container(
                            decoration: elevatedBoxStyle,
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
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: categoryItems.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          ItemIncrementWithText(
                                            itemName: categoryItems[index].name,
                                            maxQuantity: categoryItems[index].amount,
                                            onChanged: (val) {
                                              Item currentItem = Item.clone(categoryItems[index]);
                                              currentItem.amount = val;
                                              donation.items.removeWhere(
                                                  (prevItem) => prevItem.name == currentItem.name && prevItem.category == currentItem.category);
                                              if (currentItem.amount != 0) donation.items.add(currentItem);
                                            },
                                          ),
                                          SizedBox(height: 10.0),
                                        ],
                                      );
                                    },
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
                                                  Item currentItem = Item.clone(item);
                                                  currentItem.amount = val;
                                                  donation.items.removeWhere(
                                                      (prevItem) => prevItem.name == currentItem.name && prevItem.category == currentItem.category);
                                                  if (currentItem.amount != 0) donation.items.add(currentItem);
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
                          SizedBox(height: 10.0),
                        ],
                      )))
                  .values
                  .toList(),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    if (donation.items.length == 0) {
                      showDialog(context: context, builder: (_) => NoActionAlert(title: 'Please select at least one item to donate'));
                    } else if (donation.date == null) {
                      showDialog(context: context, builder: (_) => NoActionAlert(title: 'Please enter the expected delivery date of the donation'));
                    } else if (donation.date.isBefore(today)) {
                      print(donation.date);
                      showDialog(context: context, builder: (_) => NoActionAlert(title: 'The expected delivery date cannot be before today'));
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DonationConfirmationPage(widget.organization, donation)),
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
