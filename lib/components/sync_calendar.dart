import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';

class SyncCalendar extends StatelessWidget {
  SyncCalendar(this.donations, this.isOrg);

  final List<Donation> donations;
  final bool isOrg;
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Wrap(
            children: <Widget>[
              ...calendars.map((calendar) {
                return ListTile(
                  onTap: () async {
                    if (!tapped) {
                      var calendarEventsResult = await deviceCalendarPlugin.retrieveEvents(calendar.id,
                          RetrieveEventsParams(startDate: DateTime.now().add(Duration(days: -69)), endDate: DateTime.now().add(Duration(days: 365))));
                      List<Event> events = [];
                      for (Event event in calendarEventsResult.data) {
                        if (event.title.substring(0, 21) == 'A Linkare delivery of') continue;
                        bool yes = false;
                        for (Donation donation in donations) {
                          if (event.eventId == donation.sync) {
                            yes = true;
                            break;
                          }
                        }
                        if (!yes) events.add(event);
                      }
                      for (Event event in events) {
                        deviceCalendarPlugin.deleteEvent(calendar.id, event.eventId);
                      }
                      for (int i = 0; i < donations.length; i++) {
                        Donation donation = donations[i];
                        Event event = Event(calendar.id);
                        if (donation.sync != '' && donation.sync != null) event.eventId = donation.sync;
                        event.allDay = true;
                        event.start = donation.date;
                        event.end = donation.date;
                        event.location = donation.organization.address;
                        event.title = isOrg ? 'Delivery from ${donation.volunteerName}' : 'Delivery to ${donation.organization.name}';
                        String description = 'A Linkare delivery of\n';
                        for (Item item in donation.items)
                          description +=
                              ' ${item.amount}${item.unit != '' ? ' ' + item.unit : ''} ${item.name}${item.specificDescription != '' ? ' ' + item.specificDescription : ''}\n';
                        event.description = description;
                        await deviceCalendarPlugin.createOrUpdateEvent(event).then((val) async {
                          if (tapped)
                            ;
                          else if ((donation.sync == '' || donation.sync == null) && isOrg) {
                            donation.sync = val.data;
                            await db
                                .collection('organizations')
                                .doc(donation.organization.id)
                                .collection('currentDonations')
                                .doc(donation.id)
                                .update({'sync': val.data}).then((val) {
                              Navigator.of(context).pop();
                            });
                          } else if (donation.sync == '' || donation.sync == null) {
                            donation.sync = val.data;
                            await db
                                .collection('volunteers')
                                .doc(donation.volunteerId)
                                .collection('currentDonations')
                                .doc(donation.id)
                                .update({'sync': val.data}).then((val) {
                              Navigator.of(context).pop();
                            });
                          } else
                            Navigator.pop(context);
                          tapped = true;
                        });
                      }
                    }
                  },
                  title: Text(calendar.name),
                  leading: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(
                      Icons.calendar_today,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
