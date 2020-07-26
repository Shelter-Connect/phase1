import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phase1/models/donation.dart';

import '../constants.dart';
import 'alerts.dart';

// ...

class BasicDateField extends StatelessWidget {
  final format = DateFormat("MM-dd-yyyy");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.onSecondary,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text('Enter Delivery Date',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: Column(
                children: <Widget>[
                  DateTimeField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Delivery Date',
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context, firstDate: DateTime(1900), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2100));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 0),
                    child: Container(
                      width: 1001,
                      height: 1,
                      color: colorScheme.onBackground,
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class BasicDateTimeField extends StatelessWidget {
  Donation donation;
  BasicDateTimeField({this.donation});
  final format = DateFormat("MM-dd-yyyy");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.onSecondary,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text('Enter Delivery Date',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: Column(
                children: <Widget>[
                  DateTimeField(
                    format: format,
                    // ignore: missing_return
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context, firstDate: DateTime(1900), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2100));
                      if (date != null) {
                        /*final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                        );
                        donation.date = DateTimeField.combine(date, time);*/
                        donation.date = date;
                        if (donation.date.isBefore(DateTime.now())) {
                          showDialog(context: context, builder: (_) => NoActionAlert(title: 'Please enter a date before today'));
                          donation.date = currentValue;
                        }
                        return donation.date;
                      } else {
                        donation.date = currentValue;
                        return donation.date;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 0),
                    child: Container(
                      width: 1001,
                      height: 1,
                      color: colorScheme.onBackground,
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
