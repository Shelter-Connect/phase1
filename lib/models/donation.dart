import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'item.dart';
import 'organization.dart';

class Donation {
  String volunteerId, id, volunteerEmail, volunteerName;
  Organization organization;
  DateTime date;
  List<Item> items = List();
  String sync;

  Donation({
    this.volunteerId,
    this.volunteerEmail,
    this.volunteerName,
    this.organization,
    this.id,
    this.items,
    this.date,
    this.sync = '',
  });

  Donation.fromFirestoreMap(DocumentSnapshot donationSnapshot) {
    volunteerId = donationSnapshot['volunteerId'];
    volunteerEmail = donationSnapshot['volunteerEmail'];
    volunteerName = donationSnapshot['volunteerName'];
    id = donationSnapshot.documentID;
    date = donationSnapshot['date'].toDate();
    sync = donationSnapshot['sync'];
    items = donationSnapshot['items']
        .map(
          (item) => Item(
            name: item['name'],
            amount: item['amount'],
            specificDescription: item['specificDescription'],
            category: item['category'],
            unit: item['unit'],
            urgency: item['urgency'],
            urgencyColor: (item['urgency'] == 0)
                ? Colors.transparent
                : (item['urgency'] == 1)
                    ? Colors.green
                    : (item['urgency'] == 2)
                        ? Colors.yellow
                        : Colors.red,
          ),
        )
        .toList()
        .cast<Item>();

    organization = Organization(
      name: donationSnapshot['organizationName'],
      description: donationSnapshot['organizationDescription'],
      email: donationSnapshot['organizationEmail'],
      address: donationSnapshot['organizationAddress'],
      location: Position(latitude: donationSnapshot['organizationLocation'].latitude, longitude: donationSnapshot['organizationLocation'].longitude),
      id: donationSnapshot['organizationId'],
      website: donationSnapshot['organizationWebsite'],
      number: donationSnapshot['organizationNumber'],
      donationLink: donationSnapshot['organizationDonationLink'] != null ? donationSnapshot['organizationDonationLink'] : null,
      schedule: donationSnapshot['organizationSchedule'] != null
          ? Map<String, List<dynamic>>.from(donationSnapshot['organizationSchedule'])?.map(
              (day, times) => MapEntry(
                day,
                times
                    .map((time) => new TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch((time as Timestamp).millisecondsSinceEpoch)))
                    .toList(),
              ),
            )
          : null,
      breaks: donationSnapshot['organizationBreaks'] != null ? (donationSnapshot['organizationBreaks'] as Map).map((key, value) {
        int month;
        List<int> days;
        donationSnapshot['organizationBreaks']?.forEach((monthString, daysString) {
          month = int.parse(monthString);
          for (String dayString in daysString) days.add(int.parse(dayString));
        });
        return MapEntry(month, days);
      })
      // Map<int, List<int>>.from(donationSnapshot['organizationBreaks'])
        // List<DateTimeRange>.from(
        //   (donationSnapshot['organizationBreaks'] as Map).entries
        //       .map((mapEntry) {
        //         List<String> dateRangeList = mapEntry.value;
        //         DateTime startDate = DateTime.parse(dateRangeList.first);
        //         DateTime endDate = DateTime.parse(dateRangeList.last);
        //         DateTimeRange breakRange = DateTimeRange(start: startDate, end: endDate);
        //         return breakRange;
        //   })
        // )
          : null,
    );
  }

  Donation clone() {
    return Donation(
      volunteerId: volunteerId,
      volunteerName: volunteerName,
      volunteerEmail: volunteerEmail,
      date: DateTime(date.year, date.month, date.day),
      organization: organization.clone(),
      id: id,
      items: items.map((item) => item.clone()).toList(),
    );
  }

  Map<String, dynamic> toFirestoreMap() {
    Map<String, List<DateTime>> schedule = {};
    for (String day in organization.schedule.keys) {
      List<DateTime> timeFrames = [];
      for (TimeOfDay time in organization.schedule[day]) {
        timeFrames.add(new DateTime(1969, 1, 1, time.hour, time.minute));
      }
      schedule[day] = timeFrames;
    }
    return {
      'volunteerId': volunteerId,
      'date': date,
      'items': items.map((item) => item.toFirestoreMap()).toList(),
      'organizationId': organization.id,
      'organizationName': organization.name,
      'organizationDescription': organization.description,
      'organizationDonationLink': organization.donationLink,
      'organizationSchedule': schedule,
      'organizationBreaks': organization.breaks,
      'organizationEmail': organization.email,
      'organizationAddress': organization.address,
      'organizationLocation': GeoPoint(organization.location.latitude, organization.location.longitude),
      'organizationWebsite': organization.website,
      'organizationNumber': organization.number,
      'volunteerEmail': volunteerEmail,
      'volunteerName': volunteerName,
      'sync': sync,
    };
  }
}
