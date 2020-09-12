import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/category_icon_button.dart';
import 'package:phase1/components/colored_button.dart';
import 'package:phase1/components/date_time_field.dart';
import 'package:phase1/components/dropdownmenu.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/components/increment.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

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
  int amount = 0, urgency = 0;
  String specificDescription = '', itemUnit = '';

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
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      CategoryIconDisplay(
                        name: widget.itemName ?? null,
                        asset: widget.itemIcon ?? null,
                      ),
                    ],
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
                      SizedBox(height: 20),
                      FloatingTextField(
                        hintText: 'Unit (Liters, Cans, etc.)',
                        onChanged: (val) {
                          itemUnit = val;
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
                      DropDown(
                        onChanged: (val) {
                          setState(() {
                            urgency = val - 1;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Donation Deadline Date (Option)',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
                              ),
                              BasicDateField(onChanged: (val) {
                                print('Hello');
                              } //TODO Add deadline date save feature
                                  ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          color: Colors.white,
                          onPressed: () async {
                            final List<DateTime> picked = await DateRagePicker.showDatePicker(
                                context: context,
                                initialFirstDate: DateTime.now(),
                                initialLastDate: (DateTime.now()).add( Duration(days: 7)),
                                firstDate:  DateTime(2015),
                                lastDate:  DateTime(2021)
                            );
                            if (picked != null && picked.length == 2) {
                              print(picked);
                            }
                          },
                          child: Text('Pick date range (Optional)', style: TextStyle(color: purpleAccent, fontSize: 15))
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                                category: widget.itemCategory,
                                urgency: urgency)
                          ],
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                        FlushBar(
                          message: 'Your request has been received.',
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.all(0),
                          leftBarIndicatorColor: Colors.transparent,
                        ).build(context);
                      },
                    ),
                  );
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
