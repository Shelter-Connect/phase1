import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/models/user.dart';
import 'package:provider/provider.dart';

import '../../components/floating_text_field.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';

class VolunteerEditInfoPage extends StatefulWidget {
  final String firstName, lastName;
  VolunteerEditInfoPage(this.firstName, this.lastName);

  @override
  _VolunteerEditInfoPageState createState() => _VolunteerEditInfoPageState();
}

class _VolunteerEditInfoPageState extends State<VolunteerEditInfoPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    firstNameController.text = widget.firstName;
    lastNameController.text = widget.lastName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: '',
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text('Change Your Name', style: largeTitleStyle),
              SizedBox(height: 40),
              FloatingTextField(
                hintText: 'Your First Name',
                controller: firstNameController,
              ),
              SizedBox(height: 20),
              FloatingTextField(
                hintText: 'Your Last Name',
                controller: lastNameController,
              ),
              SizedBox(height: 20),
              RoundedButton(
                color: purpleAccent,
                title: 'Update Name',
                textColor: Colors.white,
                onPressed: () {
                  db.collection('volunteers').doc(Provider.of<User>(context, listen: false).user.uid).update({
                    'firstName': firstNameController.text.trim(),
                    'lastName': lastNameController.text.trim(),
                  });
                  final String displayName = '${firstNameController.text} ${lastNameController.text}';
                  Provider.of<User>(context, listen: false).user.updateDisplayName(displayName);
                  Navigator.pop(context, {
                    'firstName': firstNameController.text,
                    'lastName': lastNameController.text,
                  });
                  FlushBar(message: 'Name Updated!', duration: Duration(milliseconds: 2000)).build(context);
                },
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
