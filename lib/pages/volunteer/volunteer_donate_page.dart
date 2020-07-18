import 'package:flutter/material.dart';
import 'package:phase1/pages/volunteer/donation_confirmation_page.dart';

import '../../components/item_increment.dart';
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
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
              ),
              Text(
                ' 5 miles away',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: purpleAccent),
              ),
              SizedBox(height: 20),
              DonatePageItemSelection(boxTitle: 'Hygiene'),
              SizedBox(height: 15),
              DonatePageItemSelection(boxTitle: 'Clothing'),
              SizedBox(height: 15),
              DonatePageItemSelection(boxTitle: 'Food'),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DonationConfirmationPage()),);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: purpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),
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
