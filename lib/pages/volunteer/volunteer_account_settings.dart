import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../navigation_tab.dart';

class VolunteerAccountPage extends StatefulWidget with NavigationTab {
  @override
  _VolunteerAccountPageState createState() => _VolunteerAccountPageState();

  @override
  String get helpDescription => 'This is a help description for your account settings.';

  @override
  IconData get icon => Icons.settings;

  @override
  String get title => 'Account Settings';
}

class _VolunteerAccountPageState extends State<VolunteerAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAE5F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Text(
                'Account Settings',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: Color(0xFF6576EC)),
              ),
            ),
            SizedBox(height: 20),
            UserInfo('Example Name', 'exampleemail@email.com', 'example_password'),
            SizedBox(height: 20),
            UserPrivacy(),
            SizedBox(height: 20),
            UserNotifications(),
            SizedBox(height: 20),
            LogoutButton(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userPassword;

  UserInfo(this.userName, this.userEmail, this.userPassword);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
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
                decoration: BoxDecoration(color: Color(0xFF6576EC), borderRadius: BorderRadius.circular(21)),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Email Address: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                  TextSpan(
                      text: userEmail,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Email Address: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                  TextSpan(
                      text: userPassword,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ))
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                onPressed: () {
                  //TODO Edit Info
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6576E6),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                    child: Text('Edit Information', style: TextStyle(color: Colors.white, fontSize: 16)),
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

class UserPrivacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 224,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'User Privacy',
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
                decoration: BoxDecoration(color: Color(0xFF6576EC), borderRadius: BorderRadius.circular(21)),
              ),
              PrivacyToggleSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 224,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Notifications',
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
                decoration: BoxDecoration(color: Color(0xFF6576EC), borderRadius: BorderRadius.circular(21)),
              ),
              NotificationToggleSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          //TODO Sign user out
        },
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: Color(0xFFFE445C),
          ),
          child: Center(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ));
  }
}

class PrivacyToggleSwitch extends StatefulWidget {

  @override
  _PrivacyToggleSwitchState createState() => _PrivacyToggleSwitchState();
}
class _PrivacyToggleSwitchState extends State<PrivacyToggleSwitch> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Switch(
        value: isSwitched,
        onChanged: (value){
          setState(() {
            isSwitched = value;
            print(isSwitched);
          });
        },
        activeTrackColor: Color(0xFFF9F9F9),
        activeColor: Color(0xFF6576EC),
      ),
      title: Text(
          'Enable Location Tracking', style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      )
      ),
    );
  }
}

class NotificationToggleSwitch extends StatefulWidget {

  @override
  _NotificationToggleSwitchState createState() => _NotificationToggleSwitchState();
}
class _NotificationToggleSwitchState extends State<NotificationToggleSwitch> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Switch(
        value: isSwitched,
        onChanged: (value){
          setState(() {
            isSwitched = value;
            print(isSwitched);
          });
        },
        activeTrackColor: Color(0xFFF9F9F9),
        activeColor: Color(0xFF6576EC),
      ),
      title: Text(
          'Enable Push Notifications', style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      )
      ),
    );
  }
}

