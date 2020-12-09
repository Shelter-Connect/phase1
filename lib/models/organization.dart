import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';

import 'item.dart';

class Organization {
  String address, website, donationLink, number, email, id, description, name;
  Position location;
  double distance;
  Map<String, List<Item>> requestedItems = Map();
  List<String> itemCategories = List();
  Map<String, List<TimeOfDay>> schedule = Map();
  List<DateTimeRange> breaks = List();

  Organization(
      {this.address,
      this.website,
      this.donationLink,
      this.email,
      this.id,
      this.description,
      this.name,
      this.location,
      this.distance,
      this.requestedItems,
      this.itemCategories,
      this.number,
      this.schedule,
      this.breaks});

  Organization clone() {
    return Organization(
      address: address,
      location: location,
      website: website,
      donationLink: donationLink,
      number: number,
      email: email,
      id: id,
      description: description,
      name: name,
      itemCategories: itemCategories,
      requestedItems: requestedItems?.map(
        (category, items) => MapEntry(
          category,
          items.map((item) => item.clone()).toList(),
        ),
      ),
      schedule: schedule?.map(
        (day, times) => MapEntry(
          day,
          times.map((time) => new TimeOfDay(hour: time.hour, minute: time.minute)).toList(),
        ),
      ),
      breaks: breaks?.map((dateRange) => new DateTimeRange(start: dateRange.start, end: dateRange.end))?.toList(),
      distance: distance,
    );
  }

  Organization.fromFirestoreMap({BuildContext context, DocumentSnapshot organizationSnapshot, bool isVolunteer}) {
    address = organizationSnapshot['address'];
    location = Position(longitude: organizationSnapshot['location'].longitude, latitude: organizationSnapshot['location'].latitude);
    website = organizationSnapshot['website'];
    donationLink = organizationSnapshot['donationLink'];
    number = organizationSnapshot['number'];
    email = organizationSnapshot['email'];
    id = organizationSnapshot.documentID;
    description = organizationSnapshot['description'];
    name = organizationSnapshot['name'];
    itemCategories = organizationSnapshot['itemCategories']?.cast<String>();

    Map<String, List<Item>> items = {};
    if (organizationSnapshot['itemCategories'] != null) if (organizationSnapshot['itemCategories'].length != 0) {
      for (String category in organizationSnapshot['itemCategories']) {
        items[category] = List<Item>();
      }
    }
    requestedItems = items;

    schedule = Map<String, List<dynamic>>.from(organizationSnapshot['schedule'])?.map(
      (day, times) => MapEntry(
        day,
        times.map((time) => new TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch((time as Timestamp).millisecondsSinceEpoch))).toList(),
      ),
    );

    // breaks = organizationSnapshot['breaks'].entries.map((mapEntry) {
    //   DateTime startDate = DateTime.parse(mapEntry.value[0]);
    //   DateTime endDate = DateTime.parse(mapEntry.value[1]);
    //   return DateTimeRange(start: startDate, end: endDate);
    // }).toList();

    organizationSnapshot['breaks']?.forEach((positionInMap, dateTimes) {
      DateTime startDate = DateTime.parse(dateTimes[0]);
      DateTime endDate = DateTime.parse(dateTimes[1]);
      DateTimeRange breakRange = DateTimeRange(start: startDate, end: endDate);
      breaks.add(breakRange);
    });

    // breaks = List<dynamic>.from(organizationSnapshot['breaks'])
    //     .map((positionInMap, dateTimes) {
    //       DateTime startDate = DateTime(DateTime.parse(dateTimes[0]));
    //       DateTime endDate = DateTime(DateTime.parse(dateTimes[1]));
    //       return DateTimeRange(start: startDate, end: endDate);
    //     })
    //     .toList();

    if (isVolunteer) {
      Position userPosition = Provider.of<UserPosition>(context, listen: false).position;
      distance = userPosition != null
          ? LocationHelper.distance(
              organizationSnapshot['location'].latitude, organizationSnapshot['location'].longitude, userPosition.latitude, userPosition.longitude)
          : null;
    }
  }
}
