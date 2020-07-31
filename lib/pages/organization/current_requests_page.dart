import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/requests_container.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../navigation_tab.dart';

class CurrentRequestsPage extends StatefulWidget with NavigationTab {
  @override
  _CurrentRequestsPageState createState() => _CurrentRequestsPageState();

  @override
  String get helpDescription =>
      '''This is the Organization Current Requests Page Page! Here you can see all the items that the you have ordered but that volunteers have not committed to yet!''';

  @override
  IconData get icon => Icons.list;

  @override
  String get title => 'Current Requests';
}

class _CurrentRequestsPageState extends State<CurrentRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Current Requests',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
            ),
            SizedBox(height: 10),
            Material(
              borderRadius: BorderRadius.circular(41),
              elevation: 5,
              child:Container(
                width: 100,
                height: 50,
                decoration: subElevatedBoxStyle,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    //TODO: Make Editing Feature
                  },
                  child: Row(
                    children: <Widget>[
                      Text('Edit', style: TextStyle(color: purpleAccent, fontSize: 17, fontWeight: FontWeight.normal)),
                      Spacer(),
                      Icon(
                        Icons.edit,
                        color: purpleAccent,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
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
                    child: RequestContainer(
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
    );
  }
}
