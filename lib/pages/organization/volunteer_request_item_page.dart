import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/category_icon_button.dart';
import 'package:phase1/components/dropdownmenu.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../components/secondary_layout.dart';

class VolunteerItemPage extends StatefulWidget {
  final String itemCategory;
  final String asset;

  VolunteerItemPage({this.itemCategory = 'Other', this.asset = 'assets/other_svgs/other.svg'});

  @override
  _VolunteerItemPageState createState() => _VolunteerItemPageState();
}

class _VolunteerItemPageState extends State<VolunteerItemPage> {
  int amount = 0;
  String specificDescription = '', itemName, itemUnit;

  @override
  Widget build(BuildContext context) {
    return SecondaryLayout(
      title: '',
      helpText:
          'To create a custom request, enter the name and amount of items you need. You can also enter extra descriptions to get a specific type of item, '
          'or units for the item.',
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
                      text: 'Choose Custom Item Specifics',
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
              Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        CategoryIconDisplay(
                          name: widget.itemCategory,
                          asset: widget.asset,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 20),
                      FloatingTextField(
                        hintText: 'Custom Item Name',
                        onChanged: (val) {
                          itemName = val;
                        },
                      ),
                      SizedBox(height: 20),
                      FloatingTextField(
                        hintText: 'Custom Item Unit',
                        onChanged: (val) {
                          itemUnit = val;
                        },
                      ),
                      SizedBox(height: 20),
                      FloatingTextField(
                        hintText: 'Item Description (Specific Brand, Type, etc.)',
                        width: double.infinity,
                        maxLines: null,
                        onChanged: (val) {
                          specificDescription = val;
                        },
                      ),
                      SizedBox(height: 20),
                      ItemIncrementCreateRequest(
                        onChanged: (val) {
                          setState(() {
                            amount = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  DropDown(),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
//                    showDialog(
//                      context: context,
//                      builder: (_) => SingleActionAlert(
//                        title: 'Confirm your request?',
//                        subtitle:
//                            'Make sure you are requesting the correct item and number of items. Requests can be edited in the \'Expected Deliveries\' tab.',
//                        actionName: 'Create Request',
//                        action: () {
//                          FirestoreHelper.updateRequests(
//                            context: context,
//                            items: [
//                              Item(name: itemName, amount: amount, specificDescription: specificDescription, category: widget.itemCategory, unit: itemUnit),
//                            ],
//                          );
//                          Navigator.pop(context);
//                          Navigator.pop(context);
                       // },
                     // ),
                    //);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: colorScheme.onSecondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                    child: Text(
                      'Create Request',
                      style: TextStyle(color: purpleAccent, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
