import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/deliveries_container.dart';
import 'package:phase1/components/sync_calendar.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../navigation_tab.dart';

class CurrentDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _CurrentDeliveriesPageState createState() => _CurrentDeliveriesPageState();

  @override
  String get helpDescription =>
      'This page shows all the donations you have signed up for. In each container, you can see the name of the organization you are donating to, the date by which you will be delivering the item(s), and the exact item. Each item will have a '
          'name, amount, and specific description. '
          'The circle on the right indicates the urgency of the delivery, and red circles are attached to overdue deliveries. Click on a delivery to see more information, '
      'or to edit or cancel the delivery. ';

  @override
  Widget get icon => SvgPicture.asset(
      "assets/jam_icons/car.svg", color: purpleAccent);

  @override
  Widget get activeIcon => SvgPicture.asset(
      "assets/jam_icons/car-f.svg", color: purpleAccent);

  @override
  String get title => 'Deliver';

  @override
  String get barTitle => 'Items To Deliver';
}

class _CurrentDeliveriesPageState extends State<CurrentDeliveriesPage> {
  bool hasPosition = true;
  List<Donation> donations;

  @override
  void initState() {
    LocationHelper.getUserPosition().then((position) {
      setState(() {
        Provider.of<UserPosition>(context, listen: false).position = position;
      });
    }).catchError((error) {
      if (Provider.of<UserPosition>(context, listen: false).position == null) {
        setState(() {
          hasPosition = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (Provider.of<UserPosition>(context).position == null && hasPosition)
              ? Center(child: CircularProgressIndicator())
              : Consumer<List<Donation>>(
                  builder: (context, donations, widget) {
                    if (donations == null) {
                      return Center(
                        child: SizedBox(height: 40.0, width: 40.0, child: CircularProgressIndicator()),
                      );
                    }
                    if (donations.length == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You have no items to deliver. Go sign up for some donations!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 40),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/ui_svgs/deli.svg',
                                  semanticsLabel: 'Go Discover More Organizations to Help!',
                                  width: MediaQuery.of(context).size.width,
                                ),
                              )),
                          SizedBox(height: 20),
                        ],
                      );
                    }
                    List<Widget> widgets = [];
                    for (Donation donation in donations) {
                      widgets.add(
                        Items(donation: donation),
                      );
                    }
                    for (int i = 1; i < widgets.length; i++) {
                      widgets.insert(
                        i++,
                        SizedBox(height: 16.0),
                      );
                    }
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FlatButton(
                            onPressed: () async {
                              var status = await Permission.calendar.status;
                              if (status.isRestricted || status.isPermanentlyDenied || status.isDenied) {
                                return SingleActionAlert(
                                    title: 'Calendar Access',
                                    subtitle: 'To allow Linkare to access your calendar, please give it permissions it settings',
                                    actionName: 'Open Settings',
                                    action: () {
                                      openAppSettings();
                                    });
                              } else if (status.isUndetermined) await Permission.calendar.request();
                              await _retrieveCalendars();
                              showModalBottomSheet(context: context, builder: (context) => SyncCalendar(donations, false));
                            },
                            color: purpleAccent,
                            padding: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Feather.upload_cloud,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text('Sync', style: TextStyle(fontSize: 17, color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: widgets,
                        ),
                      ],
                    );
                  },
                ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

Future<void> _retrieveCalendars() async {
  try {
    var permissionsGranted = await deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && !permissionsGranted.data) {
      permissionsGranted = await deviceCalendarPlugin.requestPermissions();
      if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
        return;
      }
    }

    calendars = (await deviceCalendarPlugin.retrieveCalendars())?.data;
  } on PlatformException catch (e) {
    print(e);
  }
}
