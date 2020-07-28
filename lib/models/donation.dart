import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'item.dart';
import 'organization.dart';

class Donation {
  String volunteerId, donationId, volunteerEmail;
  Organization organization;
  DateTime date;
  List<Item> items = List();

  Donation({
    this.volunteerId,
    this.volunteerEmail,
    this.organization,
    this.donationId,
    this.items,
    this.date,
  });

  Donation.fromFirestoreMap({BuildContext context, DocumentSnapshot donationSnapshot}) {
    volunteerId = donationSnapshot['volunteerId'];
    donationId = donationSnapshot.documentID;
    date = donationSnapshot['date'].toDate();
    items = donationSnapshot['items'].map((item) => Item(
      name: item['name'],
      amount: item['amount'],
      specificDescription: item['specificDescription'],
      category: item['category'],
    )).toList().cast<Item>();
    organization = Organization(
      description: donationSnapshot['organizationDescription'],
      email: donationSnapshot['organizationEmail'],
      address: donationSnapshot['organizationAddress'],
      location: Position(latitude: donationSnapshot['organizationLocation'].latitude, longitude: donationSnapshot['organizationLocation'].longitude),
      id: donationSnapshot['organizationId'],
    );
  }

  Donation.clone(Donation donation) {
    this.volunteerId = donation.volunteerId;
    this.date = donation.date;
    this.date = this.date;
    this.organization = donation.organization;
    this.organization = this.organization;
    this.donationId = donationId;
    for (Item item in donation.items) {
      this.items.add(Item.clone(item: item));
    }
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'volunteerId': volunteerId,
      'date': date,
      'items': items.map((item) => item.toFirestoreMap()).toList(),
      'organizationId': organization.id,
      'organizationName': organization.name,
      'organizationDescription': organization.description,
      'organizationEmail': organization.email,
      'organizationAddress': organization.address,
      'organizationLocation': GeoPoint(organization.location.latitude, organization.location.longitude),
      'volunteerEmail': volunteerEmail,
    };
  }
}
