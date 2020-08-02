import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import 'item.dart';
import 'organization.dart';

class Donation {
  String volunteerId, donationId, volunteerEmail, volunteerName;
  Organization organization;
  DateTime date;
  List<Item> items = List();

  Donation({
    this.volunteerId,
    this.volunteerEmail,
    this.volunteerName,
    this.organization,
    this.donationId,
    this.items,
    this.date,
  });

  Donation.fromFirestoreMap(DocumentSnapshot donationSnapshot) {
    volunteerId = donationSnapshot['volunteerId'];
    volunteerEmail = donationSnapshot['volunteerEmail'];
    volunteerName = donationSnapshot['volunteerName'];
    donationId = donationSnapshot.documentID;
    date = donationSnapshot['date'].toDate();
    items = donationSnapshot['items']
        .map((item) => Item(
              name: item['name'],
              amount: item['amount'],
              specificDescription: item['specificDescription'],
              category: item['category'],
            ))
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

  Donation.clone(Donation donation) {
    this.volunteerId = donation.volunteerId;
    this.volunteerName = donation.volunteerName;
    this.volunteerEmail = donation.volunteerEmail;
    this.date = donation.date;
    this.date = this.date;
    this.organization = donation.organization;
    this.organization = this.organization;
    this.donationId = donationId;
    for (Item item in donation.items) {
      this.items.add(Item.clone(item));
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
      'volunteerName': volunteerName,
    };
  }
}
