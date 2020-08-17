import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
      this.number});

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

    if (isVolunteer) {
      Position userPosition = Provider.of<UserPosition>(context, listen: false).position;
      distance = userPosition != null
          ? LocationHelper.distance(
              organizationSnapshot['location'].latitude, organizationSnapshot['location'].longitude, userPosition.latitude, userPosition.longitude)
          : null;
    }
  }
}
