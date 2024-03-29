import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/secondary_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/pages/organization/choose_item_page.dart';
import 'package:phase1/pages/organization/other_item_page.dart';
import 'package:phase1/pages/organization/volunteer_request_item_page.dart';

import '../../components/category_icon_button.dart';

class CreateRequestPage extends StatefulWidget {
  @override
  _CreateRequestPageState createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  @override
  void initState() {
    // Categories: COVID-19, Clothes, Hygiene, Nutrition, and Warmth
    DocumentReference categoriesReference = db.collection('constants').doc('categories');
    categoriesReference.get().then((value) {
      categories.clear();
      final Map<String, Map<String, dynamic>> data = value.data();
      for (String category in data.keys) {
        String asset, description, name;
        Map<String, String> items = {};
        asset = data[category]['asset'];
        description = data[category]['description'];
        name = data[category]['name'];
        for (String item in data[category]['items'].keys) {
          items[item] = data[category]['items'][item];
        }
        categories.add({
          'asset': asset,
          'description': description,
          'name': name,
          'items': items,
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'create request',
      child: SecondaryLayout(
        title: 'Create Requests',
        helpText: 'On this page, you can create a new item request. To start, choose the category of the item you would like to receive. '
            'If the item you are looking for is not included in any category, choose the "Other" option to enter it manually.',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Create Requests: ', style: TextStyle(fontSize: 35, color: colorScheme.onSecondary, fontWeight: FontWeight.w900)),
                      TextSpan(
                        text: 'Select Category',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSecondary,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length + 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == categories.length) {
                      return CategoryIconButton(
                        asset: 'assets/random_svgs/volunteer.svg',
                        name: 'Volunteer Opportunities',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VolunteerItemPage(),
                            ),
                          );
                        },
                      );
                    } else if (index == categories.length + 1) {
                      return CategoryIconButton(
                        asset: 'assets/other_svgs/other.svg',
                        name: 'Other',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherItemPage(),
                            ),
                          );
                        },
                      );
                    } else {
                      return CategoryIconButton(
                        asset: categories[index]['asset'],
                        name: categories[index]['name'],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseItemPage(
                                categoryIcon: categories[index]['asset'],
                                categoryName: categories[index]['name'],
                                items: categories[index]['items'],
                                categoryInfo: categories[index]['description'],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
