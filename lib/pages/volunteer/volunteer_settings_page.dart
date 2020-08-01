import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/user.dart';
import '../navigation_tab.dart';

class VolunteerSettingsPage extends StatefulWidget with NavigationTab {
  @override
  _VolunteerSettingsPageState createState() => _VolunteerSettingsPageState();

  @override
  String get helpDescription => 'This is a help description for your account settings.';

  @override
  IconData get icon => Icons.settings;

  @override
  String get title => 'Account Settings';
}

class _VolunteerSettingsPageState extends State<VolunteerSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Account Settings', style: mainTitleStyle),
              SizedBox(height: 20),
              UserInfo(email: Provider.of<User>(context, listen: false).user.email, password: '*******'),
              SizedBox(height: 20),
              DeleteAccount(),
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
  final String password;

  UserInfo({this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: elevatedBoxStyle,
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
              decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
            ),
            SizedBox(height: 10),
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
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Password: ',
                    style: TextStyle(
                      fontSize: 17,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  TextSpan(
                    text: password,
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
              onTap: () {
                //TODO
              },
              child: Container(
                width: 190,
                decoration: BoxDecoration(
                  color: purpleAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.edit, color: Colors.white, size: 25),
                      SizedBox(width: 2),
                      Text(
                        'Change Password',
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
            SizedBox(height: 1)
          ],
        ),
      ),
    );
  }
}

class DeleteAccount extends StatelessWidget {
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
