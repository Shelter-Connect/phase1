import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/pages/organization/organization_edit_info_page.dart';
import 'package:phase1/pages/organization/organization_preview_page.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../constants.dart';
import '../navigation_tab.dart';
import 'edit_hours_weekdays.dart';

class OrganizationSettingsPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationSettingsPageState createState() => _OrganizationSettingsPageState();

  @override
  String get helpDescription => 'This is your Account Settings page. Here, you can see and edit your account and sign out, if you\'d like. '
      'In addition, you can preview your profile as volunteers will see it.';

  @override
  Widget get icon => SvgPicture.asset("assets/jam_icons/user-f.svg", color: purpleAccent);

  @override
  Widget get activeIcon => SvgPicture.asset("assets/jam_icons/user.svg", color: purpleAccent);

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
                DonationAvailabilityHourSettings(organization: organization),
                SizedBox(height: 20),
                DemoProfileButton(organization),
                SizedBox(height: 20),
                SignOutButton(),
                SizedBox(height: 40),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
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
              RichText(
                // Cash donations link
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Cash Donations: ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onBackground,
                      ),
                    ),
                    TextSpan(
                      text: organization.donationLink,
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
                    FlushBar(message: 'Your organization information has been updated', duration: Duration(seconds: 3)).build(context);
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
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
              EditHourContainer(day: 'Monday', timeFrames: organization.schedule['Monday'], organization: organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Tuesday', timeFrames: organization.schedule['Tuesday'], organization: organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Wednesday', timeFrames: organization.schedule['Wednesday'], organization: organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Thursday', timeFrames: organization.schedule['Thursday'], organization: organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Friday', timeFrames: organization.schedule['Friday'], organization: organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Saturday', timeFrames: organization.schedule['Saturday'], organization: organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Sunday', timeFrames: organization.schedule['Sunday'], organization: organization),
              SizedBox(height: 10),
//              Text(
//                'Specific Holiday Dates',
//                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//              ),
//              SizedBox(height: 10),
//              EditSpecificDate(month: 1, day: 2),
//              Align(
//                  alignment: Alignment.centerRight,
//                  child: IconButton(
//                    icon: Icon(Icons.add),
//                    onPressed:
//                        () {}, //TODO Add a new group with the visible delete icon
//                  )),
              SizedBox(
                height: 10,
              ),
//              InkWell(
//                onTap: () async {
//                  Map<String, List<TextEditingController>> controllerOpen = {};
//                  Map<String, List<TextEditingController>> controllerClosed = {
//                  };
//
//                  for (String key in organization.schedule.keys) {
//                    List<TextEditingController> open = [];
//                    List<TextEditingController> closed = [];
//                    for (TimeOfDay time in organization.schedule[key]) {
//                      open.add(new TextEditingController(
//                          text: time.format(context)));
//                      closed.add(new TextEditingController(
//                          text: time.format(context)));
//                    }
//                    controllerOpen.addAll({key: open});
//                    controllerClosed.addAll({key: closed});
//                  };
//                  bool updated = await Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) =>
//                          EditHours(organization: organization,
//                            controllerClosed: controllerClosed,
//                            controllerOpen: controllerOpen,),
//                    ),
//                  );
//                  if (updated) {
//                    FlushBar(
//                        message: 'Your donation availability hours has been updated',
//                        duration: Duration(seconds: 3)).build(context);
//                  }
//                },
//                child: Container(
//                  width: 140,
//                  height: 37,
//                  decoration: BoxDecoration(
//                    color: purpleAccent,
//                    borderRadius: BorderRadius.circular(21),
//                  ),
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(
//                        horizontal: 12.0, vertical: 8.0),
//                    child: Row(
//                      children: <Widget>[
//                        Icon(Icons.edit, color: Colors.white, size: 25),
//                        SizedBox(width: 2),
//                        Text(
//                          'Edit Hours', //TODO Change to : Update Business Hours
//                          style: TextStyle(
//                            color: colorScheme.onSecondary,
//                            fontWeight: FontWeight.w500,
//                            fontSize: 16.0,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
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

class EditHourContainer extends StatelessWidget {
  List<TimeOfDay> timeFrames;
  final String day;
  Organization organization;

  EditHourContainer({this.day, this.timeFrames, @required this.organization});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                child: Row(
              children: [
                SizedBox(width: 5),
                Text(
                    (day == 'Monday')
                        ? 'M'
                        : (day == 'Tuesday')
                            ? 'T'
                            : (day == 'Wednesday')
                                ? 'W'
                                : (day == 'Thursday')
                                    ? 'Th'
                                    : (day == 'Friday')
                                        ? 'F'
                                        : (day == 'Saturday')
                                            ? 'S'
                                            : (day == 'Sunday')
                                                ? 'Su'
                                                : (day == 'None'),
                    style: subTitleStyle2),
              ],
            )),
            Spacer(),
            Column(children: [
              if (timeFrames.length == 0)
                Text('Open for the Whole Day!')
              else
                for (int i = 0; i < timeFrames.length; i = i + 2)
                  Container(
                      child: Row(
                    children: [
                      Text(timeFrames[i].format(context), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                      Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                      Text(timeFrames[i + 1].format(context), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                    ],
                  )),
            ]),
            Spacer(),
            IconButton(
              icon: Icon(Feather.edit, color: Colors.red, size: 20),
              onPressed: () {
                if (timeFrames == null) timeFrames = [];
                List<TextEditingController> controllers = [];
                for (TimeOfDay time in timeFrames) controllers.add(new TextEditingController(text: time.format(context)));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditHoursWeekDay(date: day, timeFrames: timeFrames, schedule: organization.schedule, controllers: controllers)));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditSpecificDate extends StatelessWidget {
  final int month;
  final int day;

  EditSpecificDate({this.month, this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      width: MediaQuery.of(context).size.width * 0.15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
        child: Center(
          child: Container(child: Text('$month/$day', style: smallButtonStyle)),
        ),
      ),
    );
  }
}
