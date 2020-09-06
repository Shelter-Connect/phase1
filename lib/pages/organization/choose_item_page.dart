import 'package:flutter/material.dart';
import 'package:phase1/components/category_description.dart';
import 'package:phase1/components/category_icon_button.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/pages/organization/confirm_request_page.dart';
import 'package:phase1/pages/organization/other_item_page.dart';

import '../../components/secondary_layout.dart';

class ChooseItemPage extends StatelessWidget {
  final Map<String, String> items;
  final String categoryName;
  final String categoryIcon;
  final String categoryInfo;

  ChooseItemPage({
    @required this.categoryName,
    @required this.categoryIcon,
    @required this.categoryInfo,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SecondaryLayout(
      title: '',
      helpText:
          'To create a new request, choose an item that you need. If you do not see the item you are looking for, it might be in a different category, '
          'or you may have to enter it manually under the "Other" category.',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Create Requests: ', style: TextStyle(fontSize: 35, color: colorScheme.onSecondary, fontWeight: FontWeight.w900)),
                    TextSpan(
                      text: 'Choose Item',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: colorScheme.background,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Text(categoryName, style: headerStyle),
                          SizedBox(width: 5),
                          CategoryDescriptionContainer(info: categoryInfo),
                        ],
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        children: <Widget>[
                          ...items
                              .map(
                                (name, icon) => MapEntry(
                                  name,
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ItemIconButton(
                                      name: name,
                                      asset: icon,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ConfirmRequestPage(
                                              itemName: name,
                                              itemIcon: icon,
                                              itemCategory: categoryName,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                          CategoryIconButton(
                            asset: 'assets/other_svgs/other.svg',
                            name: 'Other',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtherItemPage(
                                    itemCategory: categoryName,
                                    asset: categoryIcon,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
