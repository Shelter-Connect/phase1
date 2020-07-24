import 'package:flutter/material.dart';
import 'package:phase1/components/category_icon_button.dart';
import 'package:phase1/components/create_request_info_container.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/item_increment.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/pages/organization/organization_create_request_confirm_request.dart';

import '../../components/standard_layout_purple.dart';

class OrganizationSelectItemPage extends StatelessWidget {
  final Map<String, String> items;
  final String categoryName;
  final String categoryIcon;
  final String categoryInfo;

  OrganizationSelectItemPage({
    @required this.categoryName,
    @required this.categoryIcon,
    @required this.categoryInfo,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return StandardLayout2(
        title: '',
        helpText: 'Hello, i will not help you',
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
                        text: 'Choose Item',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSecondary,
                        ))
                  ]),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorScheme.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        CategoryIconButton(
                          name: categoryName,
                          asset: categoryIcon,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CreateRequestInfoContainer(info: categoryInfo),
                        ...items
                            .map((name, icon) => MapEntry(
                                name,
                                CategoryIconButton(
                                  name: name,
                                  asset: icon,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CreateRequestConfirmRequest(
                                                  itemName: name,
                                                  itemIcon: icon,
                                                )));
                                  },
                                )))
                            .values
                            .toList()
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  hintText: 'Specific Item and/or Brand',
                  width: 225,
                  maxLines: 1,
                  //TODO Save Information to Firebase
                ),
                SizedBox(height: 20),
                ItemIncrementWithoutText(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
