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
    requestedItems = {};

    Position userPosition = Provider.of<UserPosition>(context, listen:false).position;
    distance = userPosition != null ? LocationHelper.distance(
      organizationSnapshot['location'].latitude, organizationSnapshot['location'].longitude, userPosition.latitude, userPosition.longitude
    ) : null;
  }
}
