import 'package:flutter/material.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/models/user.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'floating_text_field.dart';
import 'flushbar.dart';

class FeedbackForm extends StatefulWidget with NavigationTab {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();

  @override
  String get helpDescription => '';

  @override
  IconData get icon => Icons.feedback;

  @override
  String get title => 'Feedback';

  @override
  String get barTitle => 'Feedback';
}

class _FeedbackFormState extends State<FeedbackForm> {
  TextEditingController bug = TextEditingController(), improvement = TextEditingController();

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
              SizedBox(height: 20),
              FloatingDescriptionField(
                height: 200,
                maxLength: 1500,
                controller: bug,
                maxLines: null,
                labelText: ('Please report any bugs here'),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                counterText: '',
              ),
              SizedBox(height: 20),
              FloatingDescriptionField(
                height: 200,
                maxLength: 1500,
                controller: improvement,
                maxLines: null,
                labelText: ('What do you think we can improve on?'),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                counterText: '',
              ),
              SizedBox(height: 20),
              RoundedButton(
                title: 'Submit Feedback',
                onPressed: () {
                  db.collection('feedback').add(
                    {'bug': bug.text, 'improvement': improvement.text, 'email': Provider.of<User>(context, listen: false).user.email},
                  );
                  bug.clear();
                  improvement.clear();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Your feedback has been submitted. Thank you for your input!'),
                  ));
                  FocusScope.of(context).unfocus();
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
