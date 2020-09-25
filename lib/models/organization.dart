import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';

import 'item.dart';

class Organization {
  String address, website, number, email, id, description, name;
  Position location;
  double distance;
  Map<String, List<Item>> requestedItems = Map();
  List<String> itemCategories = List();
  Map<String, List<TimeOfDay>> schedule = Map();
  List<DateTime> breaks = List();

  Organization(
      {this.address,
      this.website,
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
      breaks: breaks.map((dates) => new DateTime(dates.year, dates.month, dates.day, dates.hour, dates.minute)).toList(),
      distance: distance,
    );
  }

  Organization.fromFirestoreMap({BuildContext context, DocumentSnapshot organizationSnapshot, bool isVolunteer}) {
    address = organizationSnapshot['address'];
    location = Position(longitude: organizationSnapshot['location'].longitude, latitude: organizationSnapshot['location'].latitude);
    website = organizationSnapshot['website'];
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

    schedule = organizationSnapshot['times']['schedule']?.map(
        (day, times) => MapEntry(day, times.map((time) => new TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(time * 1000))).toList()));
    breaks = organizationSnapshot['times']['breaks'].map((dates) => new DateTime.fromMillisecondsSinceEpoch(dates * 1000)).toList();

    if (isVolunteer) {
      Position userPosition = Provider.of<UserPosition>(context, listen: false).position;
      distance = userPosition != null
          ? LocationHelper.distance(
              organizationSnapshot['location'].latitude, organizationSnapshot['location'].longitude, userPosition.latitude, userPosition.longitude)
          : null;
    }
  }
}
