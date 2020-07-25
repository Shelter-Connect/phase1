import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/user.dart';
import '../navigation_tab.dart';

class OrganizationSettingsPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationSettingsPageState createState() => _OrganizationSettingsPageState();

  @override
  String get helpDescription => 'This is a help description for your account settings.';

  @override
  IconData get icon => Icons.settings;

  @override
  String get title => 'Account Settings';
}

class _OrganizationSettingsPageState extends State<OrganizationSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Text(
                'Account Settings',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
              ),
            ),
            SizedBox(height: 20),
            UserInfo(email: Provider.of<User>(context, listen: false).user.email, password: '*******'),
            SizedBox(height: 20),
            OrganizationInfo(),
            SizedBox(height: 20),
            DeleteAccount(),
            SizedBox(height: 20),
          ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 224,
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
                  fontSize: 24,
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
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Email Address: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: colorScheme.onBackground,
                      ),
                    ),
                    TextSpan(
                      text: email,
                      style: TextStyle(
                        fontSize: 18,
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
                        fontSize: 18,
                        color: colorScheme.onBackground,
                      ),
                    ),
                    TextSpan(
                      text: password,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onBackground,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  //TODO
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: purpleAccent,
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        color: colorScheme.onSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrganizationInfo extends StatelessWidget {
  final String email;
  final String password;

  OrganizationInfo({this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 224,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Organization Information',
                style: TextStyle(
                  fontSize: 24,
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
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Email Address: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: colorScheme.onBackground,
                      ),
                    ),
                    TextSpan(
                      text: email,
                      style: TextStyle(
                        fontSize: 18,
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
                        fontSize: 18,
                        color: colorScheme.onBackground,
                      ),
                    ),
                    TextSpan(
                      text: password,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onBackground,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  //TODO
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: purpleAccent,
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        color: colorScheme.onSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              title:
                  Text('You cannot recover your account once you delete it. All progress, past donations, and current donations will be deleted too. '
                      'Are you sure to complete this process?'),
              actions: [
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: colorScheme.secondary),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    'Delete My Account',
                    style: TextStyle(color: colorScheme.error),
                  ),
                  onPressed: () {
//                    auth.currentUser().then((user) => user.delete());
                    auth.signOut();
                    //TODO Delete DB
                  },
                ),
              ],
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
            child: Text(
              'Delete Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: colorScheme.onSecondary),
            ),
          ),
        ),
      ),
    );
  }
}