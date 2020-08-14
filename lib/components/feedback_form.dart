import 'package:flutter/material.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/pages/navigation_tab.dart';

import '../constants.dart';
import 'floating_text_field.dart';

class FeedbackForm extends StatefulWidget with NavigationTab{
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
  @override
  String get helpDescription =>
      '';

  @override
  IconData get icon => Icons.feedback;

  @override
  String get title => 'Feedback';

  @override
  String get barTitle => 'Feedback';
}

class _FeedbackFormState extends State<FeedbackForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text('Feedback Form', style: largeTitleStyle),
              SizedBox(height: 20),
              Text('We\'d love to hear your feedback!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black)),
              SizedBox(height: 40),
//                Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: FloatingTextField(
//                        hintText: 'First Name',
//                        onChanged: (val) {
//                          firstName = val.trim();
//                        },
//                      ),
//                    ),
//                    SizedBox(
//                      width: 20,
//                    ),
//                    Expanded(
//                      child: FloatingTextField(
//                        hintText: 'Last Name',
//                        onChanged: (val) {
//                          lastName = val.trim();
//                        },
//                      ),
//                    ),
//                  ],
//                ),
              SizedBox(
                height: 20,
              ),
              FloatingDescriptionField(
                height: 200,
                maxLength: 1500,
                onChanged: (val) {
                  setState(() {
//TODO: idk what you need here
                  });
                },
                maxLines: null,
                labelText: ('Please report any bugs here'),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                counterText: '',
              ),
              SizedBox(height: 20),
              FloatingDescriptionField(
                height: 200,
                maxLength: 1500,
                onChanged: (val) {
                  setState(() {
//TODO: idk what you need here
                  });
                },
                maxLines: null,
                labelText: ('What do you think we can improve on?'),
                labelStyle: TextStyle(color: Colors.grey,fontSize: 15),
                counterText: '',
              ),
              SizedBox(height: 20),
              RoundedButton(title: 'Submit Feedback', onPressed: () {
//TODO: Submit Feedback to Firebase or smt
              },
textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
      }
}
