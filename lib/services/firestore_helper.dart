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

    Set<String> requestTypes = Set<String>();
    for (Item item in items) {
      requestTypes.add(item.type);
      QuerySnapshot document = await requestsReference.where('name', isEqualTo: item.name).where('type', isEqualTo: item.type).getDocuments();
      if (document.documents.length == 0) {
        await requestsReference.add(item.toFirestoreMap());
      } else if (document.documents.length == 1) {
        DocumentSnapshot itemSnapshot = document.documents[0];
        await requestsReference.document(itemSnapshot.documentID).updateData({
          'amount': item.amount + itemSnapshot['amount'],
        });
      } else {
        throw new Exception('ERROR: Cannot have duplicate items with same name and type in collection');
      }
    }

    List<String> itemTypes = (await organizationReference.get())['itemTypes'];
    if (itemTypes != null) {
      for (String type in itemTypes) {
        requestTypes.add(type);
      }
    }
    await organizationReference.updateData({
      'requestTypes': requestTypes.toList(),
    });
  }
}