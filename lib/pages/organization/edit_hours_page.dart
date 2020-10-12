import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:phase1/components/edit_hours_dates.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/organization.dart';

class EditHours extends StatefulWidget {
  Organization organization;
  Map<String, List<TextEditingController>> controllerOpen = {};
  Map<String, List<TextEditingController>> controllerClosed = {};

  EditHours({this.organization});

  @override
  _EditHoursState createState() => _EditHoursState();
}

class _EditHoursState extends State<EditHours> {
  @override
  void initState() {
    for (String key in widget.organization.schedule.keys) {
      List<TextEditingController> open;
      List<TextEditingController> closed;
      for (TimeOfDay time in widget.organization.schedule[key]) {
        open.add(new TextEditingController(text: time.format(context)));
        closed.add(new TextEditingController(text: time.format(context)));
      }
      widget.controllerOpen.addAll({key: open});
      widget.controllerClosed.addAll({key: closed});
    }
    ;
    super.initState();
  }

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
                    //organization: widget.organization,
                    day: 'Monday',
                  ),
                  EditHoursDate(
                    //organization: widget.organization,
                    day: 'Tuesday',
                  ),
                  EditHoursDate(
                    //organization: widget.organization,
                    day: 'Wednesday',
                  ),
                  EditHoursDate(
                    //organization: widget.organization,
                    day: 'Thursday',
                  ),
                  EditHoursDate(
                    //organization: widget.organization,
                    day: 'Friday',
                  ),
                  EditHoursDate(
                    //organization: widget.organization,
                    day: 'Saturday',
                  ),
                  EditHoursDate(
                    //organization: widget.organization,
                    day: 'Sunday',
                  ),
                  SizedBox(height: 20),
                  Text('Specific Dates:'),
                  RoundedButton(
                    color: purpleAccent,
                    textColor: Colors.white,
                    onPressed: () async {
                      final List<DateTime> picked = await DateRagePicker.showDatePicker(
                          context: context,
                          initialFirstDate: DateTime.now(),
                          initialLastDate: (DateTime.now()).add(Duration(days: 7)),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2021));
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
