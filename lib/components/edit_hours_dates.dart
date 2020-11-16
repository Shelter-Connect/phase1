import 'package:flutter/material.dart';

import '../constants.dart';
import 'floating_text_field.dart';

class EditHoursDate extends StatefulWidget {
  final TextEditingController controllerOpen;
  final TextEditingController controllerClosed;
  TimeOfDay open, closed;
  String day;
  bool isActive;
  bool isEditing;

  EditHoursDate({@required this.day, this.controllerOpen, this.controllerClosed, this.isActive, this.open, this.closed, this.isEditing});

  @override
  _EditHoursDateState createState() => _EditHoursDateState();
}

class _EditHoursDateState extends State<EditHoursDate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: widget.isActive,
              checkColor: Colors.white,
              activeColor: purpleAccent,
              focusColor: Colors.grey,
              hoverColor: Colors.grey,
              onChanged: (val) => this.setState(() {
                widget.isActive = !widget.isActive;
              }),
            ),
//            Expanded(
//              child: Text(
//                widget.day,
//                style: TextStyle(
//                  fontWeight: FontWeight.w500,
//                  fontSize: 18.0,
//                ),
//              ),
//            ),
            SizedBox(width: 5),
            FloatingTextField(
              width: 100,
              height: 45,
              hintText: 'Open', //widget.isEditing ? widget.open.format(context) :
              controller: TextEditingController(text: widget.open.toString()),
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
                if (widget.isActive != null) {
                  setState(() {
                    time = picked;
                  });
                  widget.controllerOpen.text = picked.format(context);
                }
              },
            ),
            SizedBox(
              width: 15,
            ),
            Text('to', style: TextStyle(fontSize: 20)),
            SizedBox(
              width: 15,
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
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
