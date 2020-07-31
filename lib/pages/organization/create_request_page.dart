import 'package:flutter/material.dart';
import 'package:phase1/components/secondary_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/pages/organization/choose_item_page.dart';

import '../../components/category_icon_button.dart';

class CreateRequestPage extends StatefulWidget {
  @override
  _CreateRequestPageState createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'create request',
      child: SecondaryLayout(
        title: 'Create Requests',
        helpText: '''   This is the Create Requests Page. Choose any category from which you would like to request and specify the amount desired. 
   You could also name a specific item from this page and specify the quantity desired.''',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Create Requests: ', style: TextStyle(fontSize: 35, color: colorScheme.onSecondary, fontWeight: FontWeight.w900)),
                    TextSpan(
                        text: 'Select Category',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSecondary,
                        ))
                  ]),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (BuildContext context, int i) {
                            return CategoryIconButton(
                                asset: categories[i][0],
                                name: categories[i][1],
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChooseItemPage(
                                            categoryIcon: categories[i][0],
                                            categoryName: categories[i][1],
                                            items: categories[i][2],
                                            categoryInfo: categories[i][3])),
                                  );
                                });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
