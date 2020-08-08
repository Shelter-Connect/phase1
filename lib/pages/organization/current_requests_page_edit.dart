import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/requests_container.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

class CurrentRequestsPageEdit extends StatefulWidget {
  @override
  _CurrentRequestsPageEditState createState() => _CurrentRequestsPageEditState();
}

class _CurrentRequestsPageEditState extends State<CurrentRequestsPageEdit> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Edit Current Requests',
                style: mainTitleStyle,
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: FirestoreHelper.getCurrentOrganizationReference(context).collection('requests').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  Map<String, List<Item>> itemCategories = {};
                  for (DocumentSnapshot document in snapshot.data.documents) {
                    if (!itemCategories.containsKey(document['category'])) {
                      itemCategories[document['category']] = [];
                    }
                    itemCategories[document['category']].add(Item(
                      name: document['name'],
                      category: document['category'],
                      amount: document['amount'],
                      specificDescription: document['specificDescription'],
                    ));
                  }

                  List<Widget> requestContainers = [];
                  for (String category in itemCategories.keys) {
                    requestContainers.add(Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: EditRequestContainer(
                        items: itemCategories[category],
                        category: category,
                      ),
                    ));
                  }
                  return Column(
                    children: requestContainers,
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ), title: 'Edit Current Requests',
    );
  }
}