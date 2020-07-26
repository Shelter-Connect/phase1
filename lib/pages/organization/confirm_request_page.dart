import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/category_icon_button.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/pages/organization/create_request_page.dart';

import '../../components/secondary_layout.dart';

class ConfirmRequestPage extends StatelessWidget {
  final String itemName, itemIcon;

  ConfirmRequestPage({
    this.itemName,
    this.itemIcon,
  });
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
                              name: itemName ?? null,
                              asset: itemIcon ?? null,
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
                          hintText: 'Specific Item and/or Brand',
                          width: 222,
                          maxLines: 1,
                          //TODO Save Information to Firebase
                        ),
                        SizedBox(height: 24),
                        ItemIncrementWithText(),
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
                          subtitle:
                              'Make sure you are requesting the correct item and number of items. Requests can be edited in the \'Expected Deliveries\' tab.',
                          actionName: 'Confirm & Create Request',
                          action: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CreateRequestPage()),
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
        ));
  }
}
