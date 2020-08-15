import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/donation.dart';
import '../models/item.dart';
import '../models/user.dart';

class FirestoreHelper {
  //Sends a reset password email to specified email
  static Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  //Returns the current organization user's document reference
  static DocumentReference getCurrentOrganizationReference(BuildContext context) {
    return db.collection('organizations').document(Provider.of<User>(context, listen: false).user.uid);
  }

  //Returns the current volunteer user's document reference
  static DocumentReference getCurrentVolunteerReference(BuildContext context) {
    return db.collection('volunteers').document(Provider.of<User>(context, listen: false).user.uid);
  }

  //Creates a request of items for an organization
  static Future<void> updateRequests({BuildContext context, List<Item> items, String organizationId, bool isCreating = true}) async {
    DocumentReference organizationReference =
        organizationId == null ? getCurrentOrganizationReference(context) : db.collection('organizations').document(organizationId);
    CollectionReference requestsReference = organizationReference.collection('requests');

    Set<String> itemCategories = Set<String>();
    for (Item item in items) {
      itemCategories.add(item.category);
      QuerySnapshot document = await requestsReference
          .where('name', isEqualTo: item.name)
          .where('category', isEqualTo: item.category)
          .where('unit', isEqualTo: item.unit)
          .where('specificDescription', isEqualTo: item.specificDescription)
          .getDocuments();
      if ((isCreating) && (document.documents.length == 0)) {
        if (item.amount != 0) await requestsReference.add(item.toFirestoreMap());
      } else if (document.documents.length == 1) {
        DocumentSnapshot itemSnapshot = document.documents[0];
        await requestsReference.document(itemSnapshot.documentID).updateData({
          'amount': item.amount + itemSnapshot['amount'],
        });
      } else {
        throw new Exception('ERROR: Cannot have duplicate items with same name and category in collection');
      }
    }

    List currentItemCategories = (await organizationReference.get())['itemCategories'];
    if (currentItemCategories != null) {
      for (String category in currentItemCategories.cast<String>()) {
        itemCategories.add(category);
      }
    }
    await organizationReference.updateData({
      'itemCategories': itemCategories.toList(),
    });
  }

  //Deletes a requests
  static Future<void> deleteRequest(BuildContext context, Item item) async {
    CollectionReference requestsReference = getCurrentOrganizationReference(context).collection('requests');
    QuerySnapshot document = await requestsReference
        .where('name', isEqualTo: item.name)
        .where('category', isEqualTo: item.category)
        .where('unit', isEqualTo: item.unit)
        .where('specificDescription', isEqualTo: item.specificDescription)
        .getDocuments();
    await requestsReference.document(document.documents[0].documentID).delete();
  }

  //Creates a donation from the volunteer side
  static Future<void> createDonation(BuildContext context, Donation donation) async {
    DocumentReference volunteerReference = getCurrentVolunteerReference(context);
    CollectionReference volunteerDonationCollection = volunteerReference.collection('currentDonations');
    DocumentSnapshot volunteerSnapshot = await volunteerReference.get();
    donation.volunteerName = '${volunteerSnapshot['firstName']} ${volunteerSnapshot['lastName']}';
    DocumentReference donationDocument = await volunteerDonationCollection.add(donation.toFirestoreMap());
    donation.donationId = donationDocument.documentID;

    CollectionReference organizationDonationCollection =
        db.collection('organizations').document(donation.organization.id).collection('currentDonations');
    await organizationDonationCollection.document(donation.donationId).setData(donation.toFirestoreMap());
  }

  //Moves a donation from currentDonations to pastDonations
  static Future<void> confirmDelivery(BuildContext context, Donation donation) async {
    CollectionReference volunteerCurrentDonationCollection = getCurrentVolunteerReference(context).collection('currentDonations');
    CollectionReference organizationCurrentDonationCollection = getCurrentOrganizationReference(context).collection('currentDonations');
    CollectionReference volunteerPastDonationCollection = db.collection('volunteers').document(donation.volunteerId).collection('pastDonations');
    CollectionReference organizationPastDonationCollection = getCurrentOrganizationReference(context).collection('pastDonations');

    await volunteerCurrentDonationCollection.document(donation.donationId).delete();
    await organizationCurrentDonationCollection.document(donation.donationId).delete();
    await volunteerPastDonationCollection.document(donation.donationId).setData(donation.toFirestoreMap());
    await organizationPastDonationCollection.document(donation.donationId).setData(donation.toFirestoreMap());
  }

  //cancels delivery from volunteer side
  static Future<void> cancelVolunteerDelivery(BuildContext context, Donation donation) async {
    CollectionReference volunteerDonationCollection = getCurrentVolunteerReference(context).collection('currentDonations');
    await volunteerDonationCollection.document(donation.donationId).delete();

    CollectionReference organizationDonationCollection =
        db.collection('organizations').document(donation.organization.id).collection('currentDonations');
    await organizationDonationCollection.document(donation.donationId).delete();

    updateRequests(context: context, items: donation.items, organizationId: donation.organization.id, isCreating: false);
  }
}
