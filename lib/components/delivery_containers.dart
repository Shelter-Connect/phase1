import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/past_donation.dart';
import 'package:phase1/pages/organization/delivery_information_page.dart';
import 'package:phase1/pages/organization/past_delivery_information_page.dart';

class ExpectedDeliveryContainer extends StatelessWidget {
  final Donation donation;

  ExpectedDeliveryContainer({this.donation});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeliveryInformationPage(
              donation: donation,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_right),
                    Expanded(
                      child: Text(
                        '${donation.volunteerName} ${DateFormat.yMd().format(donation.date)}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: donation.items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${donation.items[index].name} - ${donation.items[index].amount.toString()} ${donation.items[index].unit ?? ''}',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                                  if (donation.items[index].specificDescription != null)
                                    Text(
                                      donation.items[index].specificDescription,
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(color: donation.items[index].urgencyColor, borderRadius: BorderRadius.circular(40)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PastDeliveryContainer extends StatelessWidget {
  final PastDonation donation;

  PastDeliveryContainer({this.donation});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PastDeliveryInformationPage(
              donation: donation,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_right),
                    Expanded(
                      child: Text(
                        '${donation.volunteerName} ${DateFormat.yMd().format(donation.date)}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: donation.items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${donation.items[index].name} - ${donation.items[index].amount.toString()} ${donation.items[index].unit ?? ''}',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                                  if (donation.items[index].specificDescription != null)
                                    Text(
                                      donation.items[index].specificDescription,
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
