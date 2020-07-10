import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/floating_text_field.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

class OrganizationSignUpExtended extends StatefulWidget {
  @override
  _OrganizationSignUpExtendedState createState() =>
      _OrganizationSignUpExtendedState();
}

class _OrganizationSignUpExtendedState
    extends State<OrganizationSignUpExtended> {
  FirebaseUser loggedInUser;
  String organizationName, description;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

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
                hintText: 'Organization Name',
                onChanged: (val) {
                  organizationName = val.trim();
                },
              ),
              SizedBox(height: 20),
              FloatingTextField(
                onChanged: (val) {
                  setState(() {
                    description = val;
                  });
                },
                maxLines: null,
                hintText: 'Short Description of Organization',
              ),
              SizedBox(height: 20),
              FloatingTextField(
                hintText: 'Organization Location',
                onChanged: (val) {
                  //TODO: Update Organization Location Variable, have autocomplete feature to make it easy to find exact shelter location.
                },
              ),
              SizedBox(height: 30),
              RoundedButton(
                title: 'Create Account',
                onPressed: () {
                  db.collection('organizations').document(userId).updateData({
                    'name': organizationName,
                    'description': description,
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
