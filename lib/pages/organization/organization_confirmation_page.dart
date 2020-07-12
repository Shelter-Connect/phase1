import 'package:flutter/material.dart';

import '../../components/rounded_button.dart';
import '../../constants.dart';

class OrganizationConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'We have received your organization application. We will soon be following up with details on a zoom verification meeting through email.',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
