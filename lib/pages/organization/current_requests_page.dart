import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/requests_container.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../navigation_tab.dart';
import 'create_request_page.dart';

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
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Current Requests',
                style: mainTitleStyle,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFDEDEDE),
                          blurRadius: 20.0,
                          spreadRadius: 0.025,
                          offset: Offset(
                            0.0,
                            0.0,
                          )),
                    ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: Colors.white, onPressed: () {  },
                    child: IntrinsicWidth(
                      child: Row(
                        children: <Widget>[
                          Text('Edit', style: smallButtonStyle),
                          SizedBox(width: 5.0),
                          Column(
                            children: [
                              SizedBox(height: 5.0),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: purpleAccent,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),)
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
