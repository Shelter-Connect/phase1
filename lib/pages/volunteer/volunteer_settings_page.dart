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
      'This page shows your account settings and information. Here, you can edit your information, or sign out, if you\'d like. ';

  @override
  Widget get icon => SvgPicture.asset(
  "assets/jam_icons/user-f.svg", color: purpleAccent);

  @override
  Widget get activeIcon => SvgPicture.asset(
      "assets/jam_icons/user.svg", color: purpleAccent);

  @override
  String get title => 'Account';

  @override
  String get barTitle => 'Settings';
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
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text('Account Info', style: largeTitleStyle),
            SizedBox(height: 40),
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
                          text: 'First Name: ',
                          style: TextStyle(
                            fontSize: 17,
                            color: colorScheme.onBackground,
                          ),
                        ),
                        TextSpan(
                          text: widget.firstName,
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
                          text: 'Last Name: ',
                          style: TextStyle(
                            fontSize: 17,
                            color: colorScheme.onBackground,
                          ),
                        ),
                        TextSpan(
                          text: widget.lastName,
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
              onPressed: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerEditInfoPage(widget.firstName, widget.lastName)));
              }),
          SizedBox(height: 10.0),
          SignOut()],
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
        width: double.infinity,
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
