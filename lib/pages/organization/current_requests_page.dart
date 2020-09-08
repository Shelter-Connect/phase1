import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phase1/components/requests_container.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../navigation_tab.dart';
import 'edit_current_requests_page.dart';

class CurrentRequestsPage extends StatefulWidget with NavigationTab {
  @override
  _CurrentRequestsPageState createState() => _CurrentRequestsPageState();

  @override
  String get helpDescription =>
      'This is your Current Requests page. Here, you can see items that you have requested that have not volunteers have not signed up for. '
      'To see items that volunteers have committed to, check the Expected Deliveries page.';

  @override
  IconData get icon => Icons.list;

  @override
  String get title => 'Requests';

  @override
  String get barTitle => 'Current Requests';
}

class _CurrentRequestsPageState extends State<CurrentRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditCurrentRequestsPage()),
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
          SizedBox(height: 10),
          StreamBuilder(
            stream: FirestoreHelper.getCurrentOrganizationReference(context).collection('requests').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data.documents.length == 0) {
                return Column(
                  children: [
                    Text(
                      'Your organization currently does not have any requests. Create a request with the \'New Request\' button at the bottom.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/ui_svgs/shopping.svg',
                          semanticsLabel: 'Create an Item Request!',
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                );
              }
              Map<String, List<Item>> itemCategories = {};
              for (DocumentSnapshot document in snapshot.data.documents) {
                if (!itemCategories.containsKey(document['category'])) {
                  itemCategories[document['category']] = [];
                }
                itemCategories[document['category']].add(
                  Item(
                      name: document['name'],
                      category: document['category'],
                      amount: document['amount'],
                      specificDescription: document['specificDescription'],
                      unit: document['unit'],
                      urgency: document['urgency'],
                      urgencyColor: (document['urgency'] == 0)
                          ? Colors.transparent
                          : (document['urgency'] == 1) ? Colors.green : (document['urgency'] == 2) ? Colors.yellow : Colors.red),
                );
              }

              List<Widget> requestContainers = [];
              for (String category in itemCategories.keys) {
                requestContainers.add(
                  RequestContainer(
                    items: itemCategories[category],
                    category: category,
                  ),
                );
              }
              return Column(
                children: requestContainers,
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
