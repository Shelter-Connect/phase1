import 'package:flutter/material.dart';

import '../components/floating_text_field.dart';
import '../components/rounded_button.dart';
import '../components/text_button.dart';

class OrganizationConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You should have received an email back from shelterconnect20@gmail.com scheduling a zoom call. The zoom call will be used for visual confirmation and you will be sent a code.',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              FloatingTextField(
                hintText: 'Enter Verification Code',
                onChanged: (val) {
                  //TODO: Update Organization Verified or Not Variable
                },
              ),
              TextButton(
                text: 'Re-send Verification Code',
                onPressed: () {
                  //TODO Re-send the verification code
                },
              ),
              Text(
                'WARNING: This account will be the only account your organization will have',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 30),
              RoundedButton(
                title: 'VERIFY',
                onPressed: () {
                  //TODO Update Organization verification status
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
