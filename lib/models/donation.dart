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

  Donation({
    this.volunteerId,
    this.volunteerEmail,
    this.volunteerName,
    this.organization,
    this.id,
    this.items,
    this.date,
  });

  Donation.fromFirestoreMap(DocumentSnapshot donationSnapshot) {
    volunteerId = donationSnapshot['volunteerId'];
    volunteerEmail = donationSnapshot['volunteerEmail'];
    volunteerName = donationSnapshot['volunteerName'];
    id = donationSnapshot.documentID;
    date = donationSnapshot['date'].toDate();
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
                  : (item['urgency'] == 1) ? Colors.green : (item['urgency'] == 2) ? Colors.yellow : Colors.red),
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
      'volunteerName': volunteerName,
    };
  }
}
