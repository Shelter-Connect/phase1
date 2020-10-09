import 'package:flutter/material.dart';
import 'package:phase1/components/edit_hours_dates.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:phase1/models/organization.dart';

class EditHours extends StatefulWidget {
  Organization organization;

  EditHours({this.organization});

  @override
  _EditHoursState createState() => _EditHoursState();
}

class _EditHoursState extends State<EditHours> {
  bool selected = true;
  bool Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true, Sunday = true;
  TextEditingController fdas = TextEditingController();
  TextEditingController asdf = TextEditingController();

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
                    controllerClosed: asdf,
                    controllerOpen: fdas,
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
print(asdf.text);
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
