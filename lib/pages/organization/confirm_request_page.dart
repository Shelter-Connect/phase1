import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/category_icon_button.dart';
import 'package:phase1/components/colored_button.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../components/secondary_layout.dart';

class ConfirmRequestPage extends StatefulWidget {
  final String itemName, itemIcon;
  final String itemCategory;

  ConfirmRequestPage({
    this.itemName,
    this.itemIcon,
    this.itemCategory,
  });

  @override
  _ConfirmRequestPageState createState() => _ConfirmRequestPageState();
}

class _ConfirmRequestPageState extends State<ConfirmRequestPage> {
  int amount = 0;
  String specificDescription = '';
  String itemUnit = '';

  @override
  Widget build(BuildContext context) {
    return SecondaryLayout(
      title: '',
      helpText:
          'To create your request, enter the amount of items you need. You can also enter extra descriptions to get a specific type of item, or units for the item.',
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
                      text: 'Finalize Item Amount and Description',
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colorScheme.background,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          CategoryIconButton(
                            name: widget.itemName ?? null,
                            asset: widget.itemIcon ?? null,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 20),
                      FloatingTextField(
                        hintText: 'Description (Specific Brand, Type, etc.)',
                        maxLines: null,
                        onChanged: (val) {
                          specificDescription = val;
                        },
                      ),
                      SizedBox(height: 24),
                      FloatingTextField(
                        hintText: 'Unit (Liters, Cans, etc.)',
                        onChanged: (val) {
                          itemUnit = val;
                        },
                      ),
                      SizedBox(height: 24),
                      ItemIncrementCreateRequest(
                        onChanged: (val) {
                          setState(() {
                            amount = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              ColoredButton(
                color: colorScheme.onSecondary,
                textColor: purpleAccent,
                text: 'Create Request',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => SingleActionAlert(
                      title: 'Confirm your request?',
                      subtitle:
                          'Make sure you are requesting the correct item and number of items. Requests can be edited in the \'Expected Deliveries\' tab.',
                      actionName: 'Create Request',
                      action: () {
                        FirestoreHelper.updateRequests(
                          context: context,
                          items: [
                            Item(
                                name: widget.itemName,
                                amount: amount,
                                specificDescription: specificDescription,
                                unit: itemUnit,
                                category: widget.itemCategory)
                          ],
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  );
                  //TODO Add item to the request list and to the request in volunteer side
                },
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
