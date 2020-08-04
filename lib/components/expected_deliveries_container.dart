import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/pages/organization/delivery_information_page.dart';

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
      child: Container(
        decoration: elevatedBoxStyle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_right),
                    Expanded(
                      child: Text(
                        '${donation.volunteerName} ${DateFormat.yMd().format(donation.date)}',
                        overflow: TextOverflow.ellipsis,
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
                  padding: const EdgeInsets.all(10.0),
                  itemCount: donation.items.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(donation.items[index].name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                        Text(donation.items[index].amount.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
