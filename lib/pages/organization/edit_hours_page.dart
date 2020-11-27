import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/pages/organization/edit_hours_weekdays.dart';

import 'edit_hours_specificdays.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Weekly Schedule ', style: subTitleStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
                color: Color(0xFFF5F5F5),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          child: Text('M ', style: appBarTitleStyle)),
                      SizedBox(width: 40),
                      Container(
                        color: Color(0xFFF4F4F4),
                      child: Column(
                        children: [
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),),
                      Spacer(),
                      IconButton(
                        icon: Icon(Feather.edit, color: Colors.red, size: 22),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditHoursWeekDay(date: 'Monday', timeFrames: widget.organization.schedule['Monday'])));
                        },
                      ),
                    ],
                  ),
                ),),
            SizedBox(height: 10),
            Container(
              color: Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: Text('T ', style: appBarTitleStyle)),
                    SizedBox(width: 40),
                    Container(
                      color: Color(0xFFF4F4F4),
                      child: Column(
                        children: [
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),),
                    Spacer(),
                    IconButton(
                      icon: Icon(Feather.edit, color: Colors.red, size: 22),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditHoursWeekDay(date: 'Tuesday', timeFrames: widget.organization.schedule['Tuesday'],)));
                      },
                    ),
                  ],
                ),
              ),),
            SizedBox(height: 10),
            Container(
              color: Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: Text('W ', style: appBarTitleStyle)),
                    SizedBox(width: 40),
                    Container(
                      color: Color(0xFFF4F4F4),
                      child: Column(
                        children: [
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),),
                    Spacer(),
                    IconButton(
                      icon: Icon(Feather.edit, color: Colors.red, size: 22),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditHoursWeekDay(date: 'Wednesday', timeFrames: widget.organization.schedule['Wednesday'])));
                      },
                    ),
                  ],
                ),
              ),),
            SizedBox(height: 10),
            Container(
              color: Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: Text('Th', style: appBarTitleStyle)),
                    SizedBox(width: 40),
                    Container(
                      color: Color(0xFFF4F4F4),
                      child: Column(
                        children: [
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),),
                    Spacer(),
                    IconButton(
                      icon: Icon(Feather.edit, color: Colors.red, size: 22),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditHoursWeekDay(date: 'Thursday', timeFrames: widget.organization.schedule['Thursday'])));
                      },
                    ),
                  ],
                ),
              ),),
            SizedBox(height: 10),
            Container(
              color: Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: Text('F ', style: appBarTitleStyle)),
                    SizedBox(width: 40),
                    Container(
                      color: Color(0xFFF4F4F4),
                      child: Column(
                        children: [
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),),
                    Spacer(),
                    IconButton(
                      icon: Icon(Feather.edit, color: Colors.red, size: 22),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditHoursWeekDay(date: 'Friday', timeFrames: widget.organization.schedule['Friday'])));
                      },
                    ),
                  ],
                ),
              ),),
            SizedBox(height: 10),
            Container(
              color: Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: Text('S ', style: appBarTitleStyle)),
                    SizedBox(width: 40),
                    Container(
                      color: Color(0xFFF4F4F4),
                      child: Column(
                        children: [
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),),
                    Spacer(),
                    IconButton(
                      icon: Icon(Feather.edit, color: Colors.red, size: 22),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditHoursWeekDay(date: 'Saturday',timeFrames: widget.organization.schedule['Saturday'])));
                      },
                    ),
                  ],
                ),
              ),),
            SizedBox(height: 10),
            Container(
              color: Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: Text('Su', style: appBarTitleStyle)),
                    SizedBox(width: 40),
                    Container(
                      color: Color(0xFFF4F4F4),
                      child: Column(
                        children: [
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                          Row(//TODO Make this row into a widget
                            children: [
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                              Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),),
                    Spacer(),
                    IconButton(
                      icon: Icon(Feather.edit, color: Colors.red, size: 22),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditHoursWeekDay(date: 'Sunday', timeFrames: widget.organization.schedule['Sunday'])));
                      },
                    ),
                  ],
                ),
              ),),

//            Container(
//              decoration: BoxDecoration(
//                  color: Color(0xFFF5F5F5),
//                  borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(20),
//                      topRight: Radius.circular(20))),
//              child: TabBar(
//                indicatorColor: purpleAccent,
//                unselectedLabelColor: darkPurpleAccent,
//                labelColor: purpleAccent,
//                controller: _controller,
//                tabs: [
//                  Tab(
//                    icon: Text('M', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: purpleAccent),)
//                  ),
//                  Tab(
//                      icon: Text('T', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: purpleAccent),)
//                  ),
//                  Tab(
//                      icon: Text('W', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: purpleAccent),)
//                  ),
//                  Tab(
//                      icon: Text('Th', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: purpleAccent),)
//                  ),
//                  Tab(
//                      icon: Text('F', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: purpleAccent),)
//                  ),
//                  Tab(
//                      icon: Text('S', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: purpleAccent),)
//                  ),
//                  Tab(
//                      icon: Text('Su', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: purpleAccent),)
//                  ),
//                ],
//              ),
//            ),
//            Container(
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(20)),
//              height: 250,
//              width: MediaQuery.of(context).size.width,
//              child: TabBarView(
//                controller: _controller,
//                children: <Widget>[
//                  Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(10)),
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//                        child: Column(
//                          children: [
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                          ],
//                        ),
//                      )),
//                  Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(10)),
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//                        child: Column(
//                          children: [
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                          ],
//                        ),
//                      )),Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(10)),
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//                        child: Column(
//                          children: [
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                          ],
//                        ),
//                      )),Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(10)),
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//                        child: Column(
//                          children: [
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                          ],
//                        ),
//                      )),Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(10)),
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//                        child: Column(
//                          children: [
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                          ],
//                        ),
//                      )),Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(10)),
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//                        child: Column(
//                          children: [
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                          ],
//                        ),
//                      )),Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(10)),
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//                        child: Column(
//                          children: [
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                            EditHoursDate(
//                              isEditing: false,
//                              day: 'Monday',
//                              isActive: false,
//                            ),
//                            SizedBox(height: 5),
//                          ],
//                        ),
//                      )),
//                ],
//              ),
//            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Specific Dates ',
                                  style: subTitleStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Color(0xFFF5F5F5),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: Text('12/15', style: smallButtonStyle)),
                          SizedBox(width: 30),
                          Container(
                            color: Color(0xFFF4F4F4),
                            child: Column(
                              children: [
                                Row(//TODO Make this row into a widget
                                  children: [
                                    Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                                    Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                                    Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                                  ],
                                ),
                                Row(//TODO Make this row into a widget
                                  children: [
                                    Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                                    Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                                    Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                                  ],
                                ),
                                Row(//TODO Make this row into a widget
                                  children: [
                                    Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                                    Text('  -  ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                                    Text('Time:Time', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),),
                          Spacer(),
                          IconButton(
                            icon: Icon(Feather.edit, color: Colors.red, size: 22),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditHoursSpecificDay(date: '12/15')));
                            },
                          ),
                        ],
                      ),
                    ),),
                  Column(
                    children: [
//                      RoundedButton(
//                        color: purpleAccent,
//                        textColor: Colors.white,
//                        onPressed: () async {
//                          final List<DateTime> picked =
//                              await DateRagePicker.showDatePicker(
//                                  context: context,
//                                  initialFirstDate: DateTime.now(),
//                                  initialLastDate:
//                                      (DateTime.now()).add(Duration(days: 7)),
//                                  firstDate: DateTime(2015),
//                                  lastDate: DateTime(2021));
//                          if (picked != null && picked.length == 2) {
//                            print(picked);
//                          }
//                        },
//                        title: 'Dates your organization is not open',
//                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          )),
                    ],
                  )
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
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
