import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/user.dart';
import 'volunteer_edit_info_page.dart';

class VolunteerSettingsPage extends StatefulWidget with NavigationTab {
  @override
  _VolunteerSettingsPageState createState() => _VolunteerSettingsPageState();

  @override
  String get helpDescription =>
      'This page shows your account settings and information. Here, you can edit your information, or sign out, if you\'d like. ';

  @override
  IconData get icon => Icons.settings;

  @override
  String get title => 'Settings';
}

class _VolunteerSettingsPageState extends State<VolunteerSettingsPage> {
  String firstName, lastName;
  bool loading = true;

  @override
  void initState() {
    DocumentReference volunteerReference = FirestoreHelper.getCurrentVolunteerReference(context);
    volunteerReference.get().then((value) {
      setState(() {
        firstName = value['firstName'];
        lastName = value['lastName'];
        loading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Account Settings', style: mainTitleStyle),
                    SizedBox(height: 20),
                    UserInfo(email: Provider.of<User>(context, listen: false).user.email, firstName: firstName, lastName: lastName),
                    SizedBox(height: 20),
                    SignOut(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String email;
  final String firstName, lastName;

  UserInfo({this.email, this.firstName, this.lastName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: elevatedBoxStyle,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'User Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 5,
              width: 100,
              decoration: BoxDecoration(
                color: purpleAccent,
                borderRadius: BorderRadius.circular(21),
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Name: ',
                    style: TextStyle(
                      fontSize: 17,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  TextSpan(
                    text: '$firstName $lastName',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onBackground,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Email Address: ',
                    style: TextStyle(
                      fontSize: 17,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  TextSpan(
                    text: email,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onBackground,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                bool updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VolunteerEditInfoPage(firstName, lastName),
                  ),
                );
              },
              child: Container(
                height: 37,
                decoration: BoxDecoration(
                  color: purpleAccent,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Wrap(
                    children: <Widget>[
                      Icon(Icons.edit, color: Colors.white, size: 25),
                      SizedBox(width: 2),
                      Text(
                        'Change User Information',
                        style: TextStyle(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class SignOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => SingleActionAlert(
            action: () {
              auth.signOut();
            },
            actionName: 'Sign Out',
            title: 'Sign Out?',
            subtitle: 'Your login info will not be remembered.',
          ),
        );
      },
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: colorScheme.error,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.exit_to_app, color: Colors.white, size: 28),
              SizedBox(width: 5),
              Text(
                'Sign Out',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
