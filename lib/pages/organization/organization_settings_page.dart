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
import 'package:flutter/gestures.dart';
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
                  DonationAvailabilityHourSettings(organization: organization, breakRanges: organization.breaks),
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

class DonationAvailabilityHourSettings extends StatefulWidget {
  final Organization organization;
  final List<DateTimeRange> breakRanges; // Copy of organization.breaks

  DonationAvailabilityHourSettings({this.organization, this.breakRanges});

  @override
  _DonationAvailabilityHourSettingsState createState() => _DonationAvailabilityHourSettingsState();
}

class _DonationAvailabilityHourSettingsState extends State<DonationAvailabilityHourSettings> {
  List<Widget> gridViewChildren;
  List<TapGestureRecognizer> breakTapGestureRecognizers;

  @override
  void initState() {
    setState(() {
      gridViewChildren = [];
      breakTapGestureRecognizers = [];
    });
    for (DateTimeRange breakRange in widget.breakRanges) {
      TapGestureRecognizer newTapGestureRecognizer = TapGestureRecognizer()
        ..onTap = () {
          // TODO: Implement delete functionality
          int tapGestureRecognizerIndex = widget.breakRanges.indexOf(breakRange);
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            widget.breakRanges.removeAt(tapGestureRecognizerIndex);
                            breakTapGestureRecognizers.removeAt(tapGestureRecognizerIndex);
                          },
                          title: Text("Delete"),
                          leading: FittedBox(
                            fit: BoxFit.contain,
                            child: IconButton(
                              onPressed: () {
                                setState(() {

                                });
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              );
            }
          );
        };
      breakTapGestureRecognizers.add(newTapGestureRecognizer);

      Widget gridViewChild;
      if (breakRange.duration != Duration()) {
        gridViewChild = Container(
          color: Color(0xFFF5F5F5),
          width: 150,
          height: 50,
          child: Row(
            children: [
              Spacer(),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "${breakRange.start.month}/${breakRange.start.day}",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                    ),
                    TextSpan(
                      text: '-',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                      recognizer: breakTapGestureRecognizers[widget.breakRanges.indexOf(breakRange)]
                    ),
                    TextSpan(
                      text: "${breakRange.end.month}/${breakRange.end.day}",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                    )
                  ]
                ),
              ),
              Spacer(),
            ]
          ),
        );
      } else {
        gridViewChild = Container(
          color: Color(0xFFF5F5F5),
            width: 75,
            height: 50,
          child: Center(child: Text("${breakRange.start.month}/${breakRange.start.day}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)))
        );
      }
      if (gridViewChild != null) {
        setState(() {
          gridViewChildren.add(gridViewChild);
        });
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    for (TapGestureRecognizer tapGestureRecognizer in breakTapGestureRecognizers)
      tapGestureRecognizer?.dispose();
    super.dispose();
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
              GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 160, mainAxisSpacing: 12.0, crossAxisSpacing: 12.0),
                  shrinkWrap: true,
                  children: (gridViewChildren ?? [SizedBox.shrink()]),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    icon: Icon(Icons.add, size: 24, color: purpleAccent),
                    onPressed: () async {
                      int currentYear = DateTime.now().year;
                      DateTimeRange newBreakRange = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(currentYear, 1, 1),
                          lastDate: DateTime(currentYear, 12, 31),
                          helpText: "Choose one day or a range of days that your organization will have a break."
                      );
                      // TODO: - Prevent overlapping break ranges
                      print("GRID VIEW CHILDREN: $gridViewChildren");
                      setState(() {
                        widget.breakRanges.add(newBreakRange);
                      });
                      // This updates Firestore
                      Map<String, List<String>> updatedBreaksInFirestore = {};
                      widget.breakRanges.forEach((element) {
                        String startDateString = element.start.toString();
                        String endDateString = element.end.toString();
                        updatedBreaksInFirestore?.addAll({widget.breakRanges.indexOf(element).toString(): [startDateString, endDateString]});
                      });
                      FirestoreHelper.getCurrentOrganizationReference(context).updateData({
                        'breaks': updatedBreaksInFirestore
                      });
                    }),
              ),
              SizedBox(height: 10),





















//              Text(
//                'Specific Holiday Dates',
//                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//              ),
//              SizedBox(height: 10),
//              ListView.builder(
//                physics: NeverScrollableScrollPhysics(),
//                shrinkWrap: true,
//                itemCount: organization.breaks.length,
//                itemBuilder: (BuildContext context, int index) {
//                  return Wrap(
//                    alignment: WrapAlignment.start,
//                    children: [
//                      EditSpecificDate(month: organization.breaks[index], day: )
//                    ],
//                  );
//                },
//              ),
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
              icon: Icon(Feather.edit, color: purpleAccent, size: 20),
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

class EditBreakContainer extends StatefulWidget {
  final Organization organization;
  final DateTimeRange dateTimeRange;

  EditBreakContainer({@required this.organization, this.dateTimeRange});

  @override
  _EditBreakContainerState createState() => _EditBreakContainerState();
}

class _EditBreakContainerState extends State<EditBreakContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.dateTimeRange.duration != Duration() ? [ // If the range is just one day
            FittedBox(
              fit: BoxFit.contain,
              child: IconButton(
                splashRadius: 0.00000000000001, // Negligible so users do not see
                onPressed: (){},
                icon: Icon(Icons.delete, color: Colors.transparent),
                enableFeedback: false,
              ),
            ), // Empty fodder
            Spacer(),
            Text("${widget.dateTimeRange.start.month}/${widget.dateTimeRange.start.day}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
            Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
            Text("${widget.dateTimeRange.end.month}/${widget.dateTimeRange.end.day}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
            Spacer(),
            FittedBox(
              fit: BoxFit.contain,
              child: IconButton(
                onPressed: () {
                  setState(() {

                  });
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ]
              : [Text("${widget.dateTimeRange.start.month}/${widget.dateTimeRange.start.day}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black))]
        ),
      )
    );
  }
}

class AddBreakButton extends StatelessWidget {
  final List<DateTimeRange> breakRanges;

  AddBreakButton({this.breakRanges});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(Icons.add, size: 24, color: purpleAccent),
        onPressed: () async {
          int currentYear = DateTime.now().year;
          DateTimeRange newBreakRange = await showDateRangePicker(
            context: context,
            firstDate: DateTime(currentYear, 1, 1),
            lastDate: DateTime(currentYear, 12, 31),
            helpText: "Choose one day or a range of days that your organization will have a break."
          );
          breakRanges.add(newBreakRange);
          // This updates Firestore
          Map<int, List<String>> updatedBreaksInFirestore;
          breakRanges.forEach((element) {
            String startDateString = element.start.toString();
            String endDateString = element.end.toString();
            updatedBreaksInFirestore?.addAll({breakRanges.indexOf(element): [startDateString, endDateString]});
                // breakRanges.indexOf(element), (_) =>
          });
          FirestoreHelper.getCurrentOrganizationReference(context).updateData({
            'breaks': updatedBreaksInFirestore
          });
        }),
    );
  }
}

void updateBreaks(BuildContext context, List<DateTimeRange> breaks) {
  Map<int, List<String>> updatedBreaksInFirestore;
  breaks.forEach((element) {
    String startDateString = element.start.toString();
    String endDateString = element.end.toString();
    updatedBreaksInFirestore?.addAll({breaks.indexOf(element): [startDateString, endDateString]});
    // breakRanges.indexOf(element), (_) =>
  });
  FirestoreHelper.getCurrentOrganizationReference(context).updateData({
    'breaks': updatedBreaksInFirestore
  });
}

extension DateTimeComparison on DateTime { // Adds greater than operator
  bool operator >(DateTime other) {
    if (this.year <= other.year) {
      if (this.year < other.year) return false;
      // If gets to here, then years are the same
      if (this.month <= other.month) {
        if (this.month < other.month) return false;
        // Month must be the same
        if (this.day <= other.day) {
          if (this.day < other.day) return false;
          // Day must be the same
          if (this.hour <= other.hour) {
            if (this.hour < other.hour) return false;
            // Hour must be the same
            if (this.minute <= other.minute) {
              if (this.minute < other.minute) return false;
              // Minute must be the same
              if (this.second <= other.second) {
                if (this.second < other.second) return false;
                // Seconds must be the same
                if (this.millisecond <= other.millisecond) return false; // Least unit possible
              }
            }
          }
        }
      }
    }
    return true;
  }
}