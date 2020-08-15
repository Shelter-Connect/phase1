import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/models/user.dart';
import 'package:phase1/services/firestore_helper.dart';
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
      title: 'Update Your Information',
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
                onPressed: () {
                  FirestoreHelper.resetPassword(Provider.of<User>(context, listen: false).user.email);
                  showDialog(
                    context: context,
                    builder: (_) => NoActionAlert(
                      title: 'Instructions to change your password have been sent to your email address.',
                    ),
                  );
                },
                title: 'Reset Password',
                color: purpleAccent,
                textColor: Colors.white,
              ),
              RoundedButton(
                color: purpleAccent,
                title: 'Update Name',
                textColor: Colors.white,
                onPressed: () {
                  db.collection('volunteers').document(Provider.of<User>(context, listen: false).user.uid).updateData({
                    'firstName': firstNameController.text.trim(),
                    'lastName': lastNameController.text.trim(),
                  });
                  UserUpdateInfo info = UserUpdateInfo();
                  info.displayName = '${firstNameController.text} ${lastNameController.text}';
                  Provider.of<User>(context, listen: false).user.updateProfile(info);
                  Navigator.pop(context, true);
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
