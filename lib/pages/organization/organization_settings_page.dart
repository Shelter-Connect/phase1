import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/pages/organization/organization_edit_info_page.dart';
import 'package:phase1/pages/organization/organization_preview_page.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../constants.dart';
import '../navigation_tab.dart';

class OrganizationSettingsPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationSettingsPageState createState() => _OrganizationSettingsPageState();

  @override
  String get helpDescription => 'This is your Account Settings page. Here, you can see and edit your account and sign out, if you\'d like. '
      'In addition, you can preview your profile as volunteers will see it.';

  @override
  IconData get icon => Icons.person_outline;

  @override
  String get title => 'Account';

  @override
  String get barTitle => 'Account';
}

class _OrganizationSettingsPageState extends State<OrganizationSettingsPage> {
  Organization organization;

  @override
  void initState() {
    DocumentReference organizationReference = FirestoreHelper.getCurrentOrganizationReference(context);
    organizationReference.get().then((snapshot) {
      setState(() {
        organization = Organization.fromFirestoreMap(context: context, organizationSnapshot: snapshot, isVolunteer: false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return organization == null
      ? Center(
          child: CircularProgressIndicator(),
        )
      : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              OrganizationInfo(organization: organization),
              SizedBox(height: 20),
              DemoProfileButton(organization),
              SizedBox(height: 20),
              DonationAvailabilityHourSettings(),
              SizedBox(height: 20),
              DeleteAccount(),
              SizedBox(height: 20),
            ],
          ),
        );
  }
}

class OrganizationInfo extends StatelessWidget {
  final Organization organization;

  OrganizationInfo({this.organization});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Organization Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                      text: organization.name,
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
                      text: organization.email,
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
                      text: organization.address,
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
                    TextSpan(
                      text: organization.description,
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
                      text: 'Website: ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onBackground,
                      ),
                    ),
                    TextSpan(
                      text: organization.website,
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
              InkWell(
                onTap: () async {
                  bool updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrganizationEditInfoPage(organization),
                    ),
                  );
                  if (updated) {
                    FlushBar( message: 'Your organization information has been updated', duration: Duration(seconds: 3)).build(context);
                  }
                },
                child: Container(
                  width: 250,
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
                          'Edit Account Information',
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
    );
  }
}

class DonationAvailabilityHourSettings extends StatelessWidget {
  final Organization organization;

  DonationAvailabilityHourSettings({this.organization});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Donation Availability Hours',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
              Text(
                'Weekly Schedule',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('M'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('T'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('W'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('Th'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('F'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('1:30 - 2:30'),
                      ), //TODO Add date functionality
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('1:30 - 2:30'),
                      ), //TODO Add date functionality
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('1:30 - 2:30'),
                      ), //TODO Add date functionality
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('1:30 - 2:30'),
                      ), //TODO Add date functionality
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('1:30 - 2:30'),
                      ), //TODO Add date functionality
                    ]),
                  ]
              ),
              SizedBox(
                height: 10,
              ),
              Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('S'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('Su'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('1:30 - 2:30'),
                      ), //TODO Add date functionality
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('1:30 - 2:30'),
                      ), //TODO Add date functionality
                    ]),
                  ]
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  bool updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrganizationEditInfoPage(organization),
                    ),
                  );
                  if (updated) {
                    FlushBar( message: 'Your donation availability hours has been updated', duration: Duration(seconds: 3)).build(context);
                  }
                },
                child: Container(
                  width: 250,
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
                          'Edit Hours',
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

class DemoProfileButton extends StatelessWidget {
  final Organization organization;

  DemoProfileButton(this.organization);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrganizationPreviewPage(organization),
          ),
        );
      },
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: purpleAccent,
        ),
        child: Center(
          child: Text(
            'Preview Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
