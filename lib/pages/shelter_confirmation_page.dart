import 'package:flutter/material.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/components/text_button.dart';

import '../components/floating_text_fields.dart';
import 'package:phase1/constants.dart';

class ShelterConfirmation extends StatelessWidget {
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
              SizedBox(height: 40),
              Text("You should have received an email back from shelterconnect20@gmail.com scheduling a zoom call. The zoom call will be used for visual confirmation and you will sent a code", style: TextStyle(fontSize: 20)),
              SizedBox(height: 40),
              FloatingTextField(
                hintText: 'Enter Verification Code',
                onChanged: (val) {
                  //TODO: Update Shelter Verified or Not Variable
                },
              ),
              SizedBox(height: 20),
              TextButton(text: 'Re-send Verification Code', onPressed: (){
                //TODO Re-send the verification code
              },),
              SizedBox(height: 20),
              FlatButton(onPressed: (){
                //TODO Send a error alert to developers
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text('Didn\'t get it?',style: TextStyle(
                  color: colorScheme.error,
                ),),
              ),),
              Text('WARNING: This account will be the only account that will be able to represent your shelter on the app'),
              SizedBox(height: 30,),
              RoundedButton(title: 'VERFIY',onPressed: (){
                //TODO Update Shelter verification status
              },)
            ],
          ),
        ),
      ),
    );
  }
}
