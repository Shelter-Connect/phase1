import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/services/firestore_helper.dart';
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
      backgroundColor: Color(0xFFF5F5F5),
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
            OrganizationInfo(email: Provider.of<User>(context, listen: false).user.email, password: '*******'),
            SizedBox(height: 20),
            DeleteAccount(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class OrganizationInfo extends StatelessWidget {
  final String email;
  final String password, description;

  OrganizationInfo({this.email, this.password, this.description});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: '');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Expanded(
        child: Container(
          decoration: elevatedBoxStyle,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Organization Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                        text: 'Name: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onBackground,
                        ),
                      ),
                      TextSpan(
                        text: email,
                        style: TextStyle(
                          fontSize: 17,
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
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onBackground,
                        ),
                      ),
                      TextSpan(
                        text: email,
                        style: TextStyle(
                          fontSize: 17,
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
                        text: 'Address: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onBackground,
                        ),
                      ),
                      TextSpan(
                        text: email,
                        style: TextStyle(
                          fontSize: 17,
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
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Description: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onBackground,
                        ),
                      ),
                      WidgetSpan(
                        child: TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                          ),
                          controller: controller,//TODO: Make the text the original description
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
                    FirestoreHelper.resetPassword(Provider
                        .of<User>(context, listen: false)
                        .user
                        .email);
                    showDialog(
                      context: context,
                      builder: (_) =>
                          NoActionAlert(
                            title: 'Instructions to change your password have been sent to your email address.',
                          ),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 37,
                    decoration: BoxDecoration(
                      color: purpleAccent,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                SizedBox(height: 5),
              ],
            ),
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
      ),
    );
  }
}
