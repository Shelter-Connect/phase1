import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'item.dart';

class Organization {
  String address, website, number, email, id, description, name;
  Position location;
  double distance;
  Map<String, List<Item>> requestedItems = Map();
  List<String> itemCategories = List();

  Organization(
      {this.address, //d
      this.website, //d
      this.email, //d
      this.id,
      this.description, //d
      this.name, //d
      this.location,
      this.distance, //d
      this.requestedItems, //d
      this.itemCategories, //d
      this.number});

  Organization.fromFirestoreMap({BuildContext context, DocumentSnapshot organizationSnapshot}) {
    address = organizationSnapshot['address'];
    location = Position(longitude: organizationSnapshot['location'].longitude, latitude: organizationSnapshot['location'].latitude);
    website = organizationSnapshot['website'];
    number = organizationSnapshot['number'];
    email = organizationSnapshot['email'];
    id = organizationSnapshot.documentID;
    description = organizationSnapshot['description'];
    name = organizationSnapshot['name'];
    itemCategories = organizationSnapshot['itemCategories'].cast<String>();

    DocumentReference organizationReference = db.collection('organizations').document(organizationSnapshot.documentID);
    Map<String, List<Item>> items = {};

    for (String category in organizationSnapshot['itemCategories']) {
      items[category] = List<Item>();
    }
    requestedItems = items;

    Position userPosition = Provider.of<UserPosition>(context, listen: false).position;
    distance = userPosition != null
        ? LocationHelper.distance(
            organizationSnapshot['location'].latitude, organizationSnapshot['location'].longitude, userPosition.latitude, userPosition.longitude)
        : null;
  }
}
