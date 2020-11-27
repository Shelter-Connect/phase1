import 'package:flutter/material.dart';
import 'floating_text_field.dart';
class EditHoursDate extends StatefulWidget {
  final String day;
  EditHoursDate({this.day});
  @override
  _EditHoursDateState createState() => _EditHoursDateState();
}

class _EditHoursDateState extends State<EditHoursDate> {
  TextEditingController controllerOpen;
  TextEditingController controllerClosed;
  TimeOfDay open, closed;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            FloatingTextField(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 45,
              hintText: 'Open',
              controller: controllerOpen, // add this line.
              onTapped: () async {
                TimeOfDay time = TimeOfDay.now();
                FocusScope.of(context).requestFocus(new FocusNode());
                open = await showTimePicker(context: context, initialTime: time);
                if (open != null) {
                  setState(() {
                    time = open;
                  });
                  controllerOpen.text = open.format(context);
                }
              },
//              onChanged: (time){
//                organization.schedule.
//              },
            ),
            SizedBox(
              width: 15,
            ),
            Text('  -  ', style: TextStyle(fontSize: 30)),
            SizedBox(
              width: 15,
            ),
            FloatingTextField(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 45,
              hintText: 'Closed',
              controller: controllerClosed,
              // add this line.
              onTapped: () async {
                TimeOfDay time = TimeOfDay.now();
                FocusScope.of(context).requestFocus(new FocusNode());
                TimeOfDay closed = await showTimePicker(context: context, initialTime: time);
                if (closed != null) {
                  setState(() {
                    time = closed;
                  });
                  controllerClosed.text = closed.format(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
