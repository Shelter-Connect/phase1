import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/pages/volunteer/delivery_description_page.dart';
import 'package:intl/intl.dart' hide TextDirection;

class DeliveriesContainer extends StatelessWidget {
  final Donation donation;

  DeliveriesContainer({this.donation});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

        return  RawMaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryDescriptionPage(donation.organization, donation)));
            },
            child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: Icon(Icons.keyboard_arrow_right),
                        ),
                        Text(
                          donation.organization.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    donation.date.year == now.year && donation.date.month == now.month && donation.date.day == now.day ?
                    Text(
                      'Deliver by: Today', style: TextStyle(fontSize: 15),
                    ):
                    Text(
            'Deliver by: ${DateFormat('MMMMd').format(donation.date)}',
            style: TextStyle(fontSize: 15, color: donation.date.isBefore(now) ? Colors.red : Colors.black),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: donation.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '${donation.items[index].name} x ${donation.items[index].amount}',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          );
    }
  }
