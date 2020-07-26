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
}
