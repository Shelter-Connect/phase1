import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/item.dart';
import '../models/user.dart';

class FirestoreHelper {
  static DocumentReference getOrganizationReference(BuildContext context) {
    return db.collection('organizations').document(Provider.of<User>(context, listen: false).user.uid);
  }

  static Future<void> createRequest({BuildContext context, List<Item> items}) async {
    DocumentReference organizationReference = getOrganizationReference(context);
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

  static double distance(double lat1, double lng1, double lat2, double lng2) {
    //haversine formula
    var p = 0.017453292519943295; // Math.PI / 180
    var a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p)) / 2;

    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }
}
