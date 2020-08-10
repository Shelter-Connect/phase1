import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/components/requests_container.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

class EditCurrentRequestsPage extends StatefulWidget {
  @override
  _EditCurrentRequestsPageState createState() => _EditCurrentRequestsPageState();
}

class _EditCurrentRequestsPageState extends State<EditCurrentRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: 'Edit Current Requests',
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
                    requestContainers.add(
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            decoration: elevatedBoxStyle,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      '$category',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 100,
                                      decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                                    ),
                                    SizedBox(height: 10),
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: itemCategories[category].length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4.0),
                                                child: ItemIncrementWithText(initialQuantity: itemCategories[category][index].amount),
                                                //TODO: Add onChanged
                                              ),
                                              Expanded(
                                                child: Text(
                                                  itemCategories[category][index].name,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
        ),
      ),
    );
  }
}
