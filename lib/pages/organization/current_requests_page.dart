import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/requests_container.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/pages/organization/current_requests_page_edit.dart';
import 'package:phase1/services/firestore_helper.dart';
import '../navigation_tab.dart';
import 'create_request_page.dart';

class CurrentRequestsPage extends StatefulWidget with NavigationTab {
  @override
  _CurrentRequestsPageState createState() => _CurrentRequestsPageState();

  @override
  String get helpDescription => '''This is the Organization Current Requests Page Page! Here you can see all the items that the you have ordered but that volunteers have not committed to yet!''';

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
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CurrentRequestsPageEdit()),
                  );
                },
                color: purpleAccent,
                padding: EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      Text('Edit', style: TextStyle(fontSize: 17, color: Colors.white))
                    ],
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: purpleAccent,
        heroTag: 'create request',
        // Create request testing code
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRequestPage()),
          );
        },
        label: Text('New Request'),
        icon: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
