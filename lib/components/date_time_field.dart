import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicDateField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Function onChanged;
  final DateTime initialValue;

  BasicDateField({this.controller, this.labelText, @required this.onChanged, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      initialValue: initialValue,
      controller: controller,
      format: DateFormat('yMMMMEEEEd'),
      decoration: InputDecoration(
        labelText: labelText,
      ),
      onShowPicker: (context, currentValue) async {
        return await showDatePicker(context: context, firstDate: DateTime(1900), initialDate: DateTime.now(), lastDate: DateTime(3100));
      },
      onChanged: onChanged,
    );
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
      ],
    );
  }
}
