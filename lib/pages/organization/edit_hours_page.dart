import 'package:flutter/material.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:circular_check_box/circular_check_box.dart';

class EditHours extends StatefulWidget {
  @override
  _EditHoursState createState() => _EditHoursState();
}

class _EditHoursState extends State<EditHours> {
  bool selected=true ;
  @override
  Widget build(BuildContext context) {
    return StandardLayout(title: 'Edit Hours',
      titleColor: purpleAccent,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text('Weekly Schedules:'),
                  Row(
                    children: [
                      CircularCheckBox( value: this.selected, checkColor: Colors.white  ,activeColor: purpleAccent, inactiveColor: Colors.grey, disabledColor: Colors.grey , onChanged: (val) => this.setState(() { this.selected= !this.selected ;}) ),
                      WeekdayPicker(),
                      //TODO Add opening time
                      //TODO Add closing time
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(onPressed: () {  }, icon: Icon(Icons.add), color: Colors.grey,),
                  ),
                  SizedBox(height: 20),
                  Text('Specific Dates:'),
                  Row(
                    children: [
                      CircularCheckBox( value: this.selected, checkColor: Colors.white  ,activeColor: purpleAccent, inactiveColor: Colors.grey, disabledColor: Colors.grey , onChanged: (val) => this.setState(() { this.selected= !this.selected ;}) ),
                      //TODO Add specific date
                      //TODO Add opening time
                      //TODO Add closing time
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(onPressed: () {  }, icon: Icon(Icons.add), color: Colors.grey,),
                  ),

                    ],
                  )
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButton(
                color: purpleAccent,
                title: 'Update Availability Date',
                textColor: Colors.white,
                onPressed: () {
                  //TODO Add save features
                  }
              ),
            ),
          ],
        )
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


