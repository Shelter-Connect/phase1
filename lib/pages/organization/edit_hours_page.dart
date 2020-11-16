import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/components/edit_hours_dates.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/organization.dart';

class EditHours extends StatefulWidget {
  Organization organization;
  Map<String, List<TextEditingController>> controllerOpen = {};
  Map<String, List<TextEditingController>> controllerClosed = {};

  EditHours({this.organization, this.controllerOpen, this.controllerClosed});

  @override
  _EditHoursState createState() => _EditHoursState();
}

class _EditHoursState extends State<EditHours> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 7, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: 'Edit Hours',
      titleColor: purpleAccent,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
                child: Text('Weekly Schedule', style: mainTitleStyle2)),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: purpleAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: TabBar(
                indicatorColor: Colors.white,
                unselectedLabelColor: darkPurpleAccent,
                labelColor: Colors.white,
                controller: _controller,
                tabs: [
                  Tab(
                    icon: Text('M', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),)
                  ),
                  Tab(
                      icon: Text('T', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),)
                  ),
                  Tab(
                      icon: Text('W', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),)
                  ),
                  Tab(
                      icon: Text('Th', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),)
                  ),
                  Tab(
                      icon: Text('F', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),)
                  ),
                  Tab(
                      icon: Text('S', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),)
                  ),
                  Tab(
                      icon: Text('Su', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),)
                  ),
                ],
              ),
            ),
            Material(
              elevation: 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)),
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                          child: Column(
                            children: [
                              EditHoursDate(
                                isEditing: false,
                                day: 'Monday',
                                isActive: false,
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(icon: Icon(Icons.add), onPressed: () {  },))],
                          ),
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [EditHoursDate(
                            isEditing: false,
                            day: 'Monday',
                            isActive: false,
                          ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(icon: Icon(Icons.add), onPressed: () {  },))],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [EditHoursDate(
                            isEditing: false,
                            day: 'Monday',
                            isActive: false,
                          ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(icon: Icon(Icons.add), onPressed: () {  },))],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [EditHoursDate(
                            isEditing: false,
                            day: 'Monday',
                            isActive: false,
                          ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(icon: Icon(Icons.add), onPressed: () {  },))],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [EditHoursDate(
                            isEditing: false,
                            day: 'Monday',
                            isActive: false,
                          ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(icon: Icon(Icons.add), onPressed: () {  },))],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [EditHoursDate(
                            isEditing: false,
                            day: 'Monday',
                            isActive: false,
                          ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(icon: Icon(Icons.add), onPressed: () {  },))],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [EditHoursDate(
                            isEditing: false,
                            day: 'Monday',
                            isActive: false,
                          ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(icon: Icon(Icons.add), onPressed: () {  },))],
                        )),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: Text('Specific Dates:', style: mainTitleStyle2,)),
                  SizedBox(height: 10),
                  Material(
                    elevation: 2,
                    child: Column(
                      children: [
                        Container(
                          child: EditHoursDate(isEditing: false,
                            day: 'Monday',
                            isActive: false,) //TODO Change this to a date and time picker, not just time picker
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.add), onPressed: () {  },))
                      ],
                    ),
                  )
//                  RoundedButton(
//                    color: purpleAccent,
//                    textColor: Colors.white,
//                    onPressed: () async {
//                      final List<DateTime> picked = await DateRagePicker.showDatePicker(
//                          context: context,
//                          initialFirstDate: DateTime.now(),
//                          initialLastDate: (DateTime.now()).add(Duration(days: 7)),
//                          firstDate: DateTime(2015),
//                          lastDate: DateTime(2021));
//                      if (picked != null && picked.length == 2) {
//                        print(picked);
//                      }
//                    },
//                    title: 'Dates your organization is not open',
//                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
