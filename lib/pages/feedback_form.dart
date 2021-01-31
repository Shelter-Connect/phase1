import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/models/user.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../components/floating_text_field.dart';
import '../components/flushbar.dart';

class FeedbackForm extends StatefulWidget with NavigationTab {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();

  @override
  String get helpDescription => '';

  @override
  Widget get icon => Icon(Feather.message_square);

  @override
  Widget get activeIcon => Icon(Feather.message_square);

  @override
  String get title => 'Feedback';

  @override
  String get barTitle => 'Feedback Form';
}

class _FeedbackFormState extends State<FeedbackForm> {
  TextEditingController bug = TextEditingController(), improvement = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          FloatingDescriptionField(
            height: 150,
            maxLength: 1500,
            controller: bug,
            maxLines: null,
            labelText: ('Please report any bugs here.'),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
            counterText: '',
          ),
          SizedBox(height: 20),
          FloatingDescriptionField(
            height: 150,
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
              FlushBar(message: 'Thank you for the feedback!', duration: Duration(seconds: 3));
            },
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
