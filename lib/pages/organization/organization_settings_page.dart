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
  String get helpDescription => 'This is your Account Settings page. Here, you can see and edit all your account information by clicking the \'Edit Account Information\' button. '
      'In addition, you can change you donation availability hours, which are the time frames in which volunteers can drop off donations. To edit the donation hours for a day, click on the edit icon button on the right. From the Edit Hours pages,'
      'you can add new time frames, delete old or unused time frames, and edit pre-existing time frames. Click the \'Save Changes for...\' to save changes. '
      'Additionally, you can add breaks, which are days or weeks where your organization will not be receiving donations. To add new breaks, click the + button, and to delete breaks, click the red trashcan button. '
      'Finally, you can preview your profile as volunteers will see it by clicking on the \'Preview Profile\' button.';

  @override
  Widget get icon => Icon(Icons.account_circle, color: Color(0xFF6576EC));

  @override
  Widget get activeIcon => Icon(Icons.account_circle, color: Color(0xFF6576EC));

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
        organization = Organization.  fromFirestoreMap(context: context, organizationSnapshot: snapshot, isVolunteer: false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: organization == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5),
                  OrganizationInfo(organization: organization),
                  SizedBox(height: 20),
                  DonationAvailabilityHourSettings(organization: organization, breaks: organization.breaks),
                  SizedBox(height: 20),
                  DemoProfileButton(organization),
                  SizedBox(height: 20),
                  SignOutButton(),
                  SizedBox(height: 40),
                ],
              ),
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
                    FlushBar(message: 'Your organization information has been updated', duration: Duration(milliseconds: 2500)).build(context);
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

class DonationAvailabilityHourSettings extends StatefulWidget {
  final Organization organization;
  final Map<int, List<int>> breaks; // Copy of organization.breaks

  DonationAvailabilityHourSettings({this.organization, this.breaks});

  @override
  _DonationAvailabilityHourSettingsState createState() => _DonationAvailabilityHourSettingsState();
}

class _DonationAvailabilityHourSettingsState extends State<DonationAvailabilityHourSettings> {
  List<Widget> gridViewChildren;
  List<int> sortedBreakMonths;

  @override
  void initState() {
    setState(() {
      gridViewChildren = [];
      sortedBreakMonths = widget.breaks.keys.toList()..sort();
    });

    sortedBreakMonths.forEach((month) {
      List<int> breakDaysInMonth = widget.breaks[month];
      // Loop through the days, Add the GridView child
      Widget gridViewChild;
      for (int day in breakDaysInMonth) {
        gridViewChild = Container(
            decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.all(Radius.circular(7.5))
            ),
            child: Center(child:
            RichText(
                text: TextSpan(
                    text: "$month/$day",
                    style: TextStyle(fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.black),
                )
            )
            )
        );
        if (gridViewChild != null) {
          setState(() {
            gridViewChildren.add(gridViewChild);
          });
        }
      }
    });

    // The add time range button
    Widget addBreakButton = IconButton(
        icon: Icon(Icons.add, size: 24, color: purpleAccent),
        onPressed: () async {
          int currentYear = DateTime.now().year;
          DateTimeRange newBreakRange = await showDateRangePicker(
              context: context,
              firstDate: DateTime(currentYear, 1, 1),
              lastDate: DateTime(currentYear, 12, 31),
              // helpText: "Choose one day or a range of days that your organization will have a break."
          );

          // Add new breaks
          if (newBreakRange != null) // If the user just didn't press cancel
            setState(() {
              if (newBreakRange.start.month == newBreakRange.end.month) { // Simplest case - same month
                if (!widget.breaks.keys.contains(newBreakRange.start.month)) // Adds month entry if needed
                  widget.breaks[newBreakRange.start.month] = [];
                for (int day = newBreakRange.start.day; day <= newBreakRange.end.day; day++) {
                  if (!widget.breaks[newBreakRange.start.month].contains(day))
                    widget.breaks[newBreakRange.start.month].add(day);
                }
                widget.breaks[newBreakRange.start.month].sort(); // Sort them in order
              } else {
                // Iterate through each month
                for (int month = newBreakRange.start.month; month <= newBreakRange.end.month; month++) {
                  if (!widget.breaks.keys.contains(month)) // Adds month entry if needed
                    widget.breaks[month] = [];
                  int numDaysInMonth = daysInMonth(month, isLeapYear(currentYear));
                  for (int day = (month == newBreakRange.start.month ? newBreakRange.start.day : 1);
                  day <= (month == newBreakRange.end.month ? newBreakRange.end.day : numDaysInMonth);
                  day++) { // Then iterate through the days
                    if (!widget.breaks[newBreakRange.start.month].contains(day)) widget.breaks[month].add(day);
                  }
                  widget.breaks[month].sort();
                }
              }
            });
          updateBreaks(context: context, newBreaks: widget.breaks); // This updates Firestore
        }
    );
    setState(() { gridViewChildren.add(addBreakButton); });

    super.initState();
  }

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
              EditHourContainer(day: 'Monday', timeFrames: widget.organization.schedule['Monday'], organization: widget.organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Tuesday', timeFrames: widget.organization.schedule['Tuesday'], organization: widget.organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Wednesday', timeFrames: widget.organization.schedule['Wednesday'], organization: widget.organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Thursday', timeFrames: widget.organization.schedule['Thursday'], organization: widget.organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Friday', timeFrames: widget.organization.schedule['Friday'], organization: widget.organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Saturday', timeFrames: widget.organization.schedule['Saturday'], organization: widget.organization),
              SizedBox(height: 5),
              EditHourContainer(day: 'Sunday', timeFrames: widget.organization.schedule['Sunday'], organization: widget.organization),
              SizedBox(height: 10),
              Text(
                'Breaks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 125,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 2
                  ),
                  shrinkWrap: true,
                  children: (gridViewChildren ?? [SizedBox.shrink()]),
              ),

              // Delete Time Range button
              if (gridViewChildren.length > 1) // Note that gridViewChildren includes add button
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () async {
                        int currentYear = DateTime.now().year;
                        DateTimeRange breakRangeToDelete = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(currentYear, 1, 1),
                            lastDate: DateTime(currentYear, 12, 31),
                            helpText: "Choose one day or a range of days to delete from your breaks."
                        );
                        if (breakRangeToDelete != null) {
                          // Iterate through the months with days that will be deleted
                          List<int> daysToBeDeleted = [];
                          for (int month = breakRangeToDelete.start.month; month <= breakRangeToDelete.end.month; month++) {
                            if (breakRangeToDelete.start.month == breakRangeToDelete.end.month) { // Simplest case - just one month
                              for (int day = breakRangeToDelete.start.day; day <= breakRangeToDelete.end.day; day++)
                                daysToBeDeleted.add(day);
                            } else {
                              int numDaysInMonth = daysInMonth(month, isLeapYear(currentYear));
                              for (int day = (month == breakRangeToDelete.start.month ? breakRangeToDelete.start.day : 1);
                              day <= (month == breakRangeToDelete.end.month ? breakRangeToDelete.end.day : numDaysInMonth);
                              day++) { // Then iterate through the days
                                daysToBeDeleted.add(day);
                              }
                            }
                            // After creating the list, DELETE
                            if (widget.breaks.keys.contains(month)) {
                              setState(() {
                                widget.breaks[month].removeWhere((day) => daysToBeDeleted.contains(day));
                              });
                            }
                          }
                          updateBreaks(context: context, newBreaks: widget.breaks); // Update Firestore
                        }
                      },
                      icon: Icon(Icons.delete, color: Colors.red)
                  )
                ),

              SizedBox(height: 10),
              SizedBox(
                height: 10,
              ),
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
  final List<TimeOfDay> timeFrames;
  final String day;
  final Organization organization;

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
                        style: subTitleStyle),
                  ],
                )),
            Spacer(),
            Column(children: [
              if (timeFrames.length == 0)
                Text('Open for the Entire Day!', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
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
              icon: Icon(Icons.edit, color: purpleAccent, size: 20),
              onPressed: () {
                List<TextEditingController> controllers = [];
                if (timeFrames != null) {
                  for (TimeOfDay time in timeFrames) {
                    controllers.add(new TextEditingController(text: time.format(context)));
                  }
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditHoursWeekDay(day: day, timeFrames: timeFrames, schedule: organization.schedule, controllers: controllers)));
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

void updateBreaks({BuildContext context, Map<int, List<int>> newBreaks}) {
  Map<String, List<String>> updatedBreaksInFirestore = {};
  newBreaks.forEach((month, days) {
    String monthString = month.toString();
    List<String> daysString = [];
    for (int day in days) daysString.add(day.toString());
    updatedBreaksInFirestore?.addAll({monthString: daysString});
  });
  FirestoreHelper.getCurrentOrganizationReference(context).updateData({
    'breaks': updatedBreaksInFirestore
  });
}

bool isLeapYear(int year) {
  if (year % 4 == 0) {
    if (year % 100 != 0) return true; // Most common case
    else if (year % 400 == 0) return true; // For years divisible by 400 (and 100)
    else return false; // Years divisible by 100 but NOT by 400
  } else return false;
}

int daysInMonth(int month, bool isLeapYear) {
  if ([4, 6, 9, 11].contains(month)) return 30; // 30 day months
  else if ([1, 3, 5, 7, 8, 10, 12].contains(month)) return 31; // 31 day months
  else { // February - Consider leap year
    if (isLeapYear) return 29;
    else return 28;
  }
}