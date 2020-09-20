import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'floating_text_field.dart';

class EditHoursDate extends StatefulWidget {
  final TextEditingController controllerOpen;
  final TextEditingController controllerClosed;
  String day;
  var boolean;

  EditHoursDate({@required this.day, this.controllerOpen, this.controllerClosed, this.boolean});

  @override
  _EditHoursDateState createState() => _EditHoursDateState();
}

class _EditHoursDateState extends State<EditHoursDate> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularCheckBox(
            value: widget.boolean,
            checkColor: Colors.white,
            activeColor: purpleAccent,
            inactiveColor: Colors.grey,
            disabledColor: Colors.grey,
            onChanged: (val) => this.setState(() {
                  widget.boolean = !widget.boolean;
                })),
        Text(widget.day,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25.0,
            )),
        SizedBox(width: 10),
        FloatingTextField(
          width: 100,
          height: 45,
          hintText: 'Open',
          controller: widget.controllerOpen,
          // add this line.
          onTapped: () async {
            TimeOfDay time = TimeOfDay.now();
            FocusScope.of(context).requestFocus(new FocusNode());

            TimeOfDay picked = await showTimePicker(context: context, initialTime: time);
            if (picked != null) {
              setState(() {
                time = picked;
              });
              widget.controllerOpen.text = picked.format(context);
            }
          },
        ),
        SizedBox(
          width: 5,
        ),
        Text('to', style: TextStyle(fontSize: 20)),
        SizedBox(
          width: 5,
        ),
        FloatingTextField(
          width: 100,
          height: 45,
          hintText: 'Closed',
          controller: widget.controllerClosed,
          // add this line.
          onTapped: () async {
            TimeOfDay time = TimeOfDay.now();
            FocusScope.of(context).requestFocus(new FocusNode());

            TimeOfDay picked = await showTimePicker(context: context, initialTime: time);
            if (picked != null) {
              setState(() {
                time = picked;
              });
              widget.controllerClosed.text = picked.format(context);
            }
          },
        ),
      ],
    );
  }
}
