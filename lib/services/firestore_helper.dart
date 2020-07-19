import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/donation.dart';
import '../models/user.dart';

class FirestoreHelper {
  CollectionReference getOrganizationDonationReference(BuildContext context) {
    return db.collection('organizations').document(Provider.of<User>(context).user.uid).collection('donations');
  }

  void addDonation({BuildContext context, Donation donation}) {
    CollectionReference donationCollectionReference = getOrganizationDonationReference(context);
    donationCollectionReference.add(donation.toFirestoreMap());
  }
}