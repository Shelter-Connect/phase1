import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/rounded_button.dart';
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
      'You can edit your account information or sign out from this page.';

  @override
  Widget get icon => Icon(Icons.account_circle, color: Color(0xFF6576EC));

  @override
  Widget get activeIcon => Icon(Icons.account_circle, color: Color(0xFF6576EC));

  @override
  String get title => 'Account';

  @override
  String get barTitle => 'Account';
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
    return loading ? CircularProgressIndicator() : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserInfo(email: Provider.of<User>(context, listen: false).user.email, firstName: firstName, lastName: lastName),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  final String email;
  final String firstName, lastName;

  UserInfo({this.email, this.firstName, this.lastName});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String _firstName, _lastName;

  @override
  void initState() {
    _firstName = widget.firstName;
    _lastName = widget.lastName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
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
                          text: '$_firstName $_lastName',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onBackground,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
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
                          text: widget.email,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onBackground,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
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
              onPressed: () async {
                var updatedName = await Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerEditInfoPage(_firstName, _lastName)));
                if (updatedName != null) {
                  setState(() {
                    _firstName = updatedName['firstName'];
                    _lastName = updatedName['lastName'];
                  });
                }
              },
            ),
            SizedBox(height: 10.0),
            SignOut(),
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
              SizedBox(width: 5),
              Text(
                'Sign Out',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
