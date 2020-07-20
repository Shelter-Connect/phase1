import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/create_request_container.dart';
import 'package:phase1/components/create_request_info_container.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/item_increment.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/pages/organization/organization_create_request_confirm_request.dart';

import '../../components/standard_layout_purple.dart';

class CreateRequestChooseItem extends StatelessWidget {
  final String categoryName;
  final String categoryIcon;
  final String categoryInfo;
  final String name1, name2, name3, name4, name5, name6;
  final String itemIcons1, itemIcons2,itemIcons3,itemIcons4,itemIcons5,itemIcons6;

  CreateRequestChooseItem({
    @required this.categoryName,
    @required this.categoryIcon,
    @required this.categoryInfo,
    this.name1,
    this.name2,
    this.name3,
    this.name4,
    this.name5,
    this.name6,
    this.itemIcons1,
    this.itemIcons2,
    this.itemIcons3,
    this.itemIcons4,
    this.itemIcons5,
    this.itemIcons6,
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
                    TextSpan(
                        text: 'Create Requests: ',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.w900
                        )),
                    TextSpan(
                        text: 'Choose Item',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
                        CreateRequestContainer(
                          name: categoryName,
                          asset:categoryIcon,
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        CreateRequestInfoContainer(info: categoryInfo),
                        CreateRequestContainer(
                          name: name1 ,
                          asset: itemIcons1,
                          onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CreateRequestConfirmRequest(itemIcon: itemIcons1 ?? null, itemName: name1 ?? null,)));
                          },
                        ),
                        CreateRequestContainer(
                          name: name2,
                          asset: itemIcons2 ?? null,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CreateRequestConfirmRequest(itemIcon: itemIcons2, itemName: name2,)));
                          },
                        ),
                        CreateRequestContainer(
                          name: name3 ?? null,
                          asset: itemIcons3 ?? null,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CreateRequestConfirmRequest(itemIcon: itemIcons3, itemName: name3,)));
                          },
                        ),
                        CreateRequestContainer(
                          name: name4  ?? null,
                          asset: itemIcons4 ?? null,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CreateRequestConfirmRequest(itemIcon: itemIcons4, itemName: name4,)));
                          },
                        ),
                        CreateRequestContainer(
                      name: name5 ?? null,
                     asset: itemIcons5?? null,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CreateRequestConfirmRequest(itemIcon: itemIcons5 ?? null, itemName: name5 ?? null,)));
                          },
                  ),
                        CreateRequestContainer(
                          name: name6 ?? null,
                          asset: itemIcons6 ?? null,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CreateRequestConfirmRequest(itemIcon: itemIcons6 ?? null, itemName: name6 ?? null,)));
                          },
                        ),
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
