import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/category_icon_button.dart';
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
      helpText: 'Hello, i will not help you',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        FloatingTextField(
                          keyboardType: TextInputType.multiline,
                          hintText: 'Item Description (Specific Brand, Type, etc.)',
                          width: double.infinity,
                          maxLines: null,
                          onChanged: (val) {
                            specificDescription = val;
                          },
                        ),
                        SizedBox(height: 24),
                        FloatingTextField(
                          keyboardType: TextInputType.multiline,
                          hintText: 'Item Unit (Liters, Cans, Gallons, in Bulk, etc.)',
                          width: double.infinity,
                          maxLines: 1,
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => SingleActionAlert(
                          title: 'Confirm your request?',
                          subtitle: 'Make sure you are requesting the correct item and number of items. Requests can be edited in the \'Expected Deliveries\' tab.',
                          actionName: 'Create Request',
                          action: () {
                            FirestoreHelper.createRequest(
                                context: context, items: [Item(name: widget.itemName, amount: amount, specificDescription: specificDescription, category: widget.itemCategory)]);
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Your order has been processed!'),
                              ),
                            );
                          },
                        ),
                      );
                      //TODO Add item to the request list and to the request in volunteer side
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
