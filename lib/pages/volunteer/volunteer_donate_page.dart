import 'package:flutter/material.dart';
import 'package:phase1/components/volunteer_donate_page_item_selection.dart';
import 'package:phase1/pages/volunteer/donation_confirmation_page.dart';

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
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
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
