import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phase1/models/organization.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/donation.dart';
import '../models/item.dart';
import '../models/user.dart';
import 'location_helper.dart';

class FirestoreHelper {
  //Returns the current organization user's document reference
  static DocumentReference getCurrentOrganizationReference(BuildContext context) {
    return db.collection('organizations').document(Provider.of<User>(context, listen: false).user.uid);
  }

  //Returns the current volunteer user's document reference
  static DocumentReference getCurrentVolunteerReference(BuildContext context) {
    return db.collection('volunteers').document(Provider.of<User>(context, listen: false).user.uid);
  }

  //Returns an organization class given an organizationId
  static Organization getOrganization({BuildContext context, String organizationId, Position userPosition, DocumentSnapshot organizationSnapshot}) {
    return Organization(
      address: organizationSnapshot['address'],
      website: organizationSnapshot['website'],
      number: organizationSnapshot['number'],
      email: organizationSnapshot['email'],
      id: organizationId != null ? organizationId : organizationSnapshot.documentID,
      description: organizationSnapshot['description'],
      name: organizationSnapshot['name'],
      itemCategories: organizationSnapshot['itemCategories'].cast<String>(),
      distance: userPosition != null
          ? LocationHelper.distance(
              organizationSnapshot['location'].latitude, organizationSnapshot['location'].longitude, userPosition.latitude, userPosition.longitude)
          : null,
      requestedItems: Map(),
    );
  }

  static Donation getDonation({BuildContext context, String donationId, DocumentSnapshot donationSnapshot}) {
    return Donation(
      volunteerId: donationSnapshot['volunteerId'],
      organizationId: donationSnapshot['organizationId'],
      donationId: donationId != null ? donationId : donationSnapshot.documentID,
      date: donationSnapshot['date'].toDate(),
      items: donationSnapshot['items'].cast<Item>(),
    );
  }

  //Creates a request of items for an organization
  static Future<void> createRequest({BuildContext context, List<Item> items}) async {
    DocumentReference organizationReference = getCurrentOrganizationReference(context);
    CollectionReference requestsReference = organizationReference.collection('requests');

    Set<String> itemCategories = Set<String>();
    for (Item item in items) {
      itemCategories.add(item.category);
      QuerySnapshot document = await requestsReference.where('name', isEqualTo: item.name).where('category', isEqualTo: item.category).getDocuments();
      if (document.documents.length == 0) {
        await requestsReference.add(item.toFirestoreMap());
      } else if (document.documents.length == 1) {
        DocumentSnapshot itemSnapshot = document.documents[0];
        await requestsReference.document(itemSnapshot.documentID).updateData({
          'amount': item.amount + itemSnapshot['amount'],
        });
      } else {
        throw new Exception('ERROR: Cannot have duplicate items with same name and category in collection');
      }
    }

    List<String> currentItemCategories = (await organizationReference.get())['itemCategories'];
    if (currentItemCategories != null) {
      for (String category in currentItemCategories) {
        itemCategories.add(category);
      }
    }
    await organizationReference.updateData({
      'itemCategories': itemCategories.toList(),
    });
  }

  //Creates a donation from the volunteer side
  static Future<void> createDonation(BuildContext context, Donation donation) async {
    CollectionReference volunteerDonationCollection = getCurrentVolunteerReference(context).collection('currentDonations');
    DocumentReference donationDocument = await volunteerDonationCollection.add(donation.toFirestoreMap());
    donation.donationId = donationDocument.documentID;

    CollectionReference organizationDonationCollection =
        db.collection('organizations').document(donation.organizationId).collection('currentDonations');
    await organizationDonationCollection.document(donation.donationId).setData(donation.toFirestoreMap());
  }

  //Moves a donation from currentDonations to pastDonations
  static Future<void> archiveDonation(BuildContext context, String initialId, Donation receivedDonation) async {
    CollectionReference volunteerDonationCollection = getCurrentVolunteerReference(context).collection('currentDonations');
    await volunteerDonationCollection.document(initialId).delete();

    CollectionReference organizationDonationCollection =
        db.collection('organizations').document(receivedDonation.organizationId).collection('currentDonations');
    await organizationDonationCollection.document(initialId).delete();

    volunteerDonationCollection = getCurrentVolunteerReference(context).collection('pastDonations');
    DocumentReference donationDocument = await volunteerDonationCollection.add(receivedDonation.toFirestoreMap());

    organizationDonationCollection = db.collection('organizations').document(receivedDonation.organizationId).collection('pastDonations');
    await organizationDonationCollection.document(donationDocument.documentID).setData(receivedDonation.toFirestoreMap());
  }
}
