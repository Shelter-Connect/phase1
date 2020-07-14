import 'package:flutter/material.dart';

import '../../components/increment-counter.dart';
import '../../components/rounded_button.dart';
import '../../components/standard_layout.dart';
import '../../constants.dart';

class VolunteerDonatePage extends StatefulWidget {
  @override
  _VolunteerDonatePageState createState() => _VolunteerDonatePageState();
}

class _VolunteerDonatePageState extends State<VolunteerDonatePage> {
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
                '(Organization Name)',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: Color(0xFF6576EC)),
              ),
              Text(
                ' 5 miles away',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(0xFF6576EC)),
              ),
              SizedBox(height: 20),
              DonatePageItemSelection(boxTitle: 'Hygiene'),
              SizedBox(height: 15),
              DonatePageItemSelection(boxTitle: 'Clothing'),
              SizedBox(height: 15),
              DonatePageItemSelection(boxTitle: 'Food'),
              SizedBox(height: 15),
              RoundedButton(onPressed: (){
                Navigator.pushNamed(context, '/confirm_donation');
              }, title: 'Create Donation'),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}


class DonatePageItemSelection extends StatelessWidget {
  final String boxTitle;

  DonatePageItemSelection({this.boxTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  boxTitle,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(height: 10),
            ItemIncrement(itemName: 'Toilet paper'),
            SizedBox(height: 10),
            ItemIncrement(itemName: 'Pillow'),
            SizedBox(height: 10),
            ItemIncrement(itemName: 'Shoes'),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}





