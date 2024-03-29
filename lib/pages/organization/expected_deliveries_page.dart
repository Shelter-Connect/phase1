import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/sync_calendar.dart';
import 'package:phase1/models/donation.dart';
import 'package:provider/provider.dart';

import '../../components/delivery_containers.dart';
import '../../constants.dart';
import '../navigation_tab.dart';

class ExpectedDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _ExpectedDeliveriesPageState createState() => _ExpectedDeliveriesPageState();

  @override
  String get helpDescription =>
      'This is the Expected Deliveries page. Here, you can see any items that the volunteers have signed up to deliver to your organization. '
      'Click on a delivery to see more information regarding the items being delivered, the arrival time, and donor contact information.'
      'The Sync button syncs your expected deliveries to a calendar of your choice';

  @override
  Widget get icon => Icon(Icons.delivery_dining, color: Color(0xFF6576EC));

  @override
  Widget get activeIcon => Icon(Icons.delivery_dining, color: Color(0xFF6576EC));

  @override
  String get title => 'Current Deliveries';

  @override
  String get barTitle => 'Deliveries';
}

class _ExpectedDeliveriesPageState extends State<ExpectedDeliveriesPage> {
  String dropdownValue = 'Sort by';
  List<Donation> donations;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 60,
                    child: MaterialButton(
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
                        } else if (!status.isGranted || !status.isLimited) await Permission.calendar.request(); // TODO: how to check if access request hasn't been made yet?
                        await _retrieveCalendars();
                        showModalBottomSheet(context: context, builder: (context) => SyncCalendar(donations, true));
                      },
                      elevation: 2.0,
                      color: Colors.white,
                      child: Icon(
                        Icons.cloud_upload,
                        color: purpleAccent,
                        size: 25.0,
                      ),
                      padding: EdgeInsets.all(12.0),
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Consumer<List<Donation>>(
              builder: (context, donations, widget) {
                this.donations = donations;
                if (donations == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (donations.length == 0) {
                  return Column(
                    children: [
                      Text(
                        'Your organization currently does not have any expected deliveries.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/ui_svgs/dood.svg',
                            semanticsLabel: 'Create some requests!',
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                    ],
                  );
                }
                List<Widget> widgets = [];
                for (Donation donation in donations) {
                  widgets.add(
                    ExpectedDeliveryContainer(
                      donation: donation,
                    ),
                  );
                  widgets.add(
                    SizedBox(height: 20.0),
                  );
                }
                return Column(
                  children: widgets,
                );
              },
            ),
          ],
        ),
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
