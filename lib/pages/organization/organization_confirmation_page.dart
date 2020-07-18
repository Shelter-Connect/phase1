import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../components/alerts.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';
import '../../models/user.dart';

class OrganizationConfirmationPage extends StatefulWidget {
  @override
  _OrganizationConfirmationPageState createState() => _OrganizationConfirmationPageState();
}

class _OrganizationConfirmationPageState extends State<OrganizationConfirmationPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
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
                  title: 'Check Verification',
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    DocumentSnapshot organizationSnapshot = await db.collection('organizations').document(Provider.of<User>(context, listen: false).user.uid).get();
                    setState(() {
                      loading = false;
                    });

                    if (organizationSnapshot['verified']) {
                      Navigator.pushReplacementNamed(context, '/organization_navigation');
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Your organization has not been verified yet'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
