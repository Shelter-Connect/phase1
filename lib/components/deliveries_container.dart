import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/pages/volunteer/delivery_description_page.dart';

class DeliveriesContainer extends StatelessWidget {
  final Donation donation;

  DeliveriesContainer({this.donation});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryDescriptionPage(donation)));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                  Expanded(
                    child: Text(
                      donation.organization.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              donation.date.year == now.year && donation.date.month == now.month && donation.date.day == now.day
                  ? Text(
                      'Deliver by: Today',
                      style: TextStyle(fontSize: 15),
                    )
                  : Text(
                      'Deliver by: ${DateFormat('MMMMd').format(donation.date)}',
                      style: TextStyle(fontSize: 15, color: donation.date.isBefore(now) ? Colors.red : Colors.black),
                    ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 10),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: donation.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${donation.items[index].name} - ${donation.items[index].amount} ${donation.items[index].unit ?? ''}'.trim(),
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
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
    );
  }
}

class Items extends StatelessWidget {
  final Donation donation;

  Items({this.donation});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
          ),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeliveryDescriptionPage(donation)
                ),
              );
            }, //TODO
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: Icon(Icons.keyboard_arrow_right),
                      ),
                      Expanded(
                        child: Text(
                          donation.organization.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  donation.date.year == now.year && donation.date.month == now.month && donation.date.day == now.day
                      ? Text(
                          'Deliver by: Today',
                          style: TextStyle(fontSize: 15),
                        )
                      : Text(
                          'Deliver by: ${DateFormat('MMMMd').format(donation.date)}',
                          style: TextStyle(fontSize: 15, color: donation.date.isBefore(now) ? Colors.red : Colors.black),
                        ),
                  SizedBox(height: 5),
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: purpleAccent,
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: donation.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${donation.items[index].name} - ${donation.items[index].amount} ${donation.items[index].unit ?? ''}'.trim(),
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      if (donation.items[index].specificDescription != null)
                                        Text(
                                          donation.items[index].specificDescription,
                                          style: TextStyle(fontSize: 14, color: Colors.grey),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(color: donation.items[index].urgencyColor, borderRadius: BorderRadius.circular(40)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          ),
        );
  }
}
