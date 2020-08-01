import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/pages/volunteer/delivery_description_page.dart';
import 'package:intl/intl.dart';

class DeliveriesContainer extends StatelessWidget {
  final Donation donation;

  DeliveriesContainer({this.donation});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
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
                children: <Widget>[
                  Text(
                    donation.organization.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        //TODO
                      },
                    ),
                  ),
                ],
              ),
              Text('Deliver by: ${DateFormat('MMMMd').format(donation.date)}', style: TextStyle(fontSize: 15),),
              SizedBox(height: 5),
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
              ),
              SizedBox(height: 10),
              ListView.builder(
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
              SizedBox(height: 5)
            ],
          ),
        ),
      ),
    );
  }
}
