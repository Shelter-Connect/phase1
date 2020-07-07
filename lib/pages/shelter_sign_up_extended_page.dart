import 'package:flutter/material.dart';

import '../components/floating_text_fields.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

class ShelterSignUpExtended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("We're so excited to partner with you!", style: headerStyle),
              SizedBox(height: 60),
              FloatingTextField(
                hintText: 'Enter Shelter Name',
                onChanged: (val) {
                  //TODO: Update Shelter Name Variable
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                hintText: 'Enter a Brief Description',
                onChanged: (val) {
                  //TODO: Update Shelter Description Variable
                },
              ),
              SizedBox(height: 20),
              DescriptionBox(
                hintText: 'Search for Shelter Location',
                onChanged: (val) {
                  //TODO: Update Shelter Location Variable, have autocomplete feature to make it easy to find exact shelter location.
                },
              ),
              SizedBox(height: 30),
              RoundedButton(
                title: 'NEXT',
                onPressed: () {
                  //TODO Update Shelter Profile and navigate to the verification page.
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
