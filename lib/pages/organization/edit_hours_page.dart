import 'package:flutter/material.dart';
import 'package:phase1/components/edit_hours_dates.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class EditHours extends StatefulWidget {
  @override
  _EditHoursState createState() => _EditHoursState();
}

class _EditHoursState extends State<EditHours> {
  bool selected = true;
  bool Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true, Sunday = true;

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: 'Edit Hours',
      titleColor: purpleAccent,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text('Weekly Schedules:'),
//                  CheckboxListTile(
//                    contentPadding: EdgeInsets.all(5),
//                    title: const Text('Animate Slowly'),
//                    value: selected,
//                    selected: false,
//                    onChanged: (bool value) {
//                      setState(() {
//                        selected = !selected;
//                      });
//                    },
//                    secondary: const Icon(Icons.hourglass_empty),
//                  ),
//                  Text('Monday',
//                      style: TextStyle(
//                        fontWeight: FontWeight.w500,
//                        fontSize: 25.0,
//                      )),
//                  SizedBox(width: 10),
//                  FloatingTextField(
//                    width: 100,
//                    height: 45,
//                    hintText: 'Open',
//                    controller: Monday_timeCtl_1,
//                    // add this line.
//                    onTapped: () async {
//                      TimeOfDay time = TimeOfDay.now();
//                      FocusScope.of(context).requestFocus(new FocusNode());
//
//                      TimeOfDay picked = await showTimePicker(context: context, initialTime: time);
//                      if (picked != null) {
//                        setState(() {
//                          time = picked;
//                        });
//                        Monday_timeCtl_1.text = picked.format(context);
//                      }
//                    },
//                  ),
//                  SizedBox(
//                    width: 5,
//                  ),
//                  Text('to', style: TextStyle(fontSize: 20)),
//                  SizedBox(
//                    width: 5,
//                  ),
//                  FloatingTextField(
//                    width: 100,
//                    height: 45,
//                    hintText: 'Closed',
//                    controller: Monday_timeCtl_2,
//                    // add this line.
//                    onTapped: () async {
//                      TimeOfDay time = TimeOfDay.now();
//                      FocusScope.of(context).requestFocus(new FocusNode());
//
//                      TimeOfDay picked = await showTimePicker(context: context, initialTime: time);
//                      if (picked != null) {
//                        setState(() {
//                          time = picked;
//                        });
//                        Monday_timeCtl_2.text = picked.format(context);
//                      }
//                    },
//                  ),
                  EditHoursDate(
                    boolean: Monday,
                    controllerClosed: TextEditingController(),
                    controllerOpen: TextEditingController(),
                    day: 'Monday',
                  ),
                  EditHoursDate(
                    boolean: Tuesday,
                    controllerClosed: TextEditingController(),
                    controllerOpen: TextEditingController(),
                    day: 'Tuesday',
                  ),
                  EditHoursDate(
                    boolean: Wednesday,
                    controllerClosed: TextEditingController(),
                    controllerOpen: TextEditingController(),
                    day: 'Wednesday',
                  ),
                  EditHoursDate(
                    boolean: Thursday,
                    controllerClosed: TextEditingController(),
                    controllerOpen: TextEditingController(),
                    day: 'Thursday',
                  ),
                  EditHoursDate(
                    boolean: Friday,
                    controllerClosed: TextEditingController(),
                    controllerOpen: TextEditingController(),
                    day: 'Friday',
                  ),
                  EditHoursDate(
                    boolean: Saturday,
                    controllerClosed: TextEditingController(),
                    controllerOpen: TextEditingController(),
                    day: 'Saturday',
                  ),
                  EditHoursDate(
                    boolean: Sunday,
                    controllerClosed: TextEditingController(),
                    controllerOpen: TextEditingController(),
                    day: 'Sunday',
                  ),
                  SizedBox(height: 20),
                  Text('Specific Dates:'),
                  RoundedButton(
                    color: purpleAccent,
                    textColor: Colors.white,
                    onPressed: () async {
                      final List<DateTime> picked = await DateRagePicker.showDatePicker(
                          context: context, initialFirstDate: DateTime.now(), initialLastDate: (DateTime.now()).add(Duration(days: 7)), firstDate: DateTime(2015), lastDate: DateTime(2021));
                      if (picked != null && picked.length == 2) {
                        print(picked);
                      }
                    },
                    title: 'Dates your organization is not open',

                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButton(
                color: purpleAccent,
                title: 'Update Availability Date',
                textColor: Colors.white,
                onPressed: () {
                  //TODO Add save features
                },
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekdayPicker extends StatefulWidget {
  @override
  _WeekdayPickerState createState() => _WeekdayPickerState();

  final Function onChanged;

  const WeekdayPicker({this.onChanged});
}

class _WeekdayPickerState extends State<WeekdayPicker> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: _value,
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "Day",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 1,
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "All Week",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 2,
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "Monday",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 3,
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "Tuesday",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 4,
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "Wednesday",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 5,
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "Thursday",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 6,
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "Friday",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 7,
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "Saturday",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 8,
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "Sunday",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 9,
              ),
            ],
            onChanged: (value) {
              setState(() {
                widget.onChanged(value);
                _value = value;
              });
            }),
      ),
    );
  }
}
