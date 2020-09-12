import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';

class SyncCalendar extends StatelessWidget {
  SyncCalendar(this.donations, this.isOrg);

  final List<Donation> donations;
  final bool isOrg;

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
                    for (int i = 0; i < donations.length; i++) {
                      Donation donation = donations[i];
                      Event event = Event(calendar.id);
                      if (donation.sync != '' || donation.sync != null) event.eventId = donation.sync;
                      event.allDay = true;
                      event.start = donation.date;
                      event.end = donation.date;
                      event.location = donation.organization.address;
                      event.title = isOrg ? 'Delivery from ${donation.volunteerName}' : 'Delivery to ${donation.organization.name}';
                      String description = 'A delivery of\n';
                      for (Item item in donation.items)
                        description +=
                            ' ${item.amount}${item.unit != '' ? ' ' + item.unit : ''} ${item.name}${item.specificDescription != '' ? ' ' + item.specificDescription : ''}\n';
                      event.description = description;
                      final result = await deviceCalendarPlugin.createOrUpdateEvent(event);
                      donation.sync = result.data;
                      if (isOrg) {
                        await db
                            .collection('organizations')
                            .document(donation.organization.id)
                            .collection('currentDonations')
                            .document(donation.id)
                            .updateData({'sync': result.data});
                      } else
                        await db
                            .collection('volunteers')
                            .document(donation.volunteerId)
                            .collection('currentDonations')
                            .document(donation.id)
                            .updateData({'sync': result.data});
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
