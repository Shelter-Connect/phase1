import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';

DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

class SyncCalendar extends StatelessWidget {
  SyncCalendar(this.donations, this.isOrg);

  final List<Donation> donations;
  final bool isOrg;
  List<Calendar> _calendars = _retrieveCalendars();
  int i = 0;

  @override
  Widget build(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  for (Calendar calendar in _calendars)
                    ListTile(
                      onTap: () async {
                        for (Donation donation in donations) {
                          Event event = Event(calendar.id);
                          if (donation.sync != '') event.eventId = donation.sync;
                          event.allDay = true;
                          event.start = donation.date;
                          event.location = donation.organization.address;
                          event.title = isOrg ? 'Delivery from ${donation.volunteerName}' : 'Delivery to ${donation.organization.name}';
                          String description = 'A delivery of';
                          for (Item item in donation.items)
                            description +=
                                ' ${item.amount}${item.unit != '' ? ' ' + item.unit : ''} ${item.name}${item.specificDescription != '' ? ' ' + item.specificDescription : ''}\n';
                          event.description = description;
                          final result = await _deviceCalendarPlugin.createOrUpdateEvent(event);
                          donation.sync = result.data;
                          if (isOrg) {
                            db
                                .collection('organizations')
                                .document(donation.volunteerId)
                                .collection('currentDonations')
                                .document(donation.id)
                                .updateData({'sync': result.data});
                          } else
                            db
                                .collection('volunteers')
                                .document(donation.volunteerId)
                                .collection('currentDonations')
                                .document(donation.id)
                                .updateData({'sync': result.data});
                        }
                      },
                      title: Text(calendar.name),
                      leading: Image(
                        image: Icons.calendar_today as ImageProvider,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

List<Calendar> _retrieveCalendars() {
  try {
    var permissionsGranted;
    _deviceCalendarPlugin.hasPermissions().then((value) => permissionsGranted = value);
    if (permissionsGranted.isSuccess && !permissionsGranted.data) {
      _deviceCalendarPlugin.requestPermissions().then((value) => permissionsGranted = value);
      if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
        return null;
      }
    }

    var calendarsResult;
    _deviceCalendarPlugin.retrieveCalendars().then((value) => calendarsResult = value);
    return calendarsResult?.data;
  } catch (e) {
    print(e);
  }
}
