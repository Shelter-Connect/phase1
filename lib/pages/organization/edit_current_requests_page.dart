import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

class EditCurrentRequestsPage extends StatefulWidget {
  List<Item> items = List();

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
                    return Center(
                      child: CircularProgressIndicator(),
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
                      ),
                    );
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
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                textDirection: TextDirection.rtl,
                                                children: [
                                                  IconButton(icon: Icon(Icons.cancel), onPressed: () {  },
                                                      //TODO: Make it cancel
                                                      color: colorScheme.error
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 4.0),
                                                    child: ItemIncrementWithText(
                                                      initialQuantity: itemCategories[category][index].amount,
                                                      onChanged: (val) {
                                                        Item currentItem = itemCategories[category][index].clone();
                                                        currentItem.amount = val;
                                                        widget.items.removeWhere((prevItem) =>
                                                            prevItem.name == currentItem.name &&
                                                            prevItem.category == currentItem.category &&
                                                            prevItem.specificDescription == currentItem.specificDescription &&
                                                            prevItem.unit == currentItem.unit);
                                                        if (currentItem.amount != 0) widget.items.add(currentItem);
                                                      },
                                                    ),
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
                                              if (itemCategories[category][index].specificDescription != null)
                                                Text(
                                                  itemCategories[category][index].specificDescription,
                                                  style: TextStyle(fontSize: 14, color: Colors.grey),
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
                    children: [
                      Column(
                        children: requestContainers,
                      ),
                      SizedBox(height: 10),
                      RoundedButton(
                        title: 'Confirm Edit',
                        onPressed: () {
                          Navigator.pop(context);
                          List<Item> delta = List();
                          for (Item newItem in widget.items) {
                            for (String category in itemCategories.keys) {
                              for (Item oldItem in itemCategories[category]) {
                                if ((newItem.specificDescription == oldItem.specificDescription) &&
                                    (newItem.name == oldItem.name) &&
                                    (newItem.category == oldItem.category)) {
                                  Item item = newItem.clone();
                                  item.amount -= oldItem.amount;
                                  delta.add(item);
                                  break;
                                }
                              }
                            }
                          }
                          FirestoreHelper.updateRequests(context: context, items: delta);
                        },
                        textColor: Colors.white,
                      )
                    ],
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
