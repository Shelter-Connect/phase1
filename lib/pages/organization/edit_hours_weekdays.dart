import 'package:flutter/material.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../constants.dart';

class EditHoursWeekDay extends StatefulWidget {
  final String date;
  Map<String, List<TimeOfDay>> schedule;
  List<TimeOfDay> timeFrames;
  List<TextEditingController> controllers = [];
  Map<String, List<DateTime>> temp = {};

  EditHoursWeekDay({@required this.date, @required this.timeFrames, @required this.schedule, @required this.controllers});

  @override
  _EditHoursWeekDayState createState() => _EditHoursWeekDayState();
}

class _EditHoursWeekDayState extends State<EditHoursWeekDay> {
  @override
  void initState() {
    if (widget.timeFrames == null) widget.timeFrames = [];
    widget.schedule[widget.date] = widget.timeFrames;
    for (String dayOfWeek in widget.schedule.keys) {
      List<DateTime> day = [];
      DateTime now = DateTime.now();
      for (TimeOfDay time in widget.schedule[dayOfWeek]) day.add(new DateTime(now.year, now.month, now.day, time.hour, time.minute));
      widget.temp[dayOfWeek] = day;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
        title: 'Edit Hours: ${widget.date}',
        titleColor: purpleAccent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                for (int i = 0; i < widget.timeFrames.length; i = i + 2)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        color: Color(0xFFF5F5F5),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 5),
                              FloatingTextField(
                                width: MediaQuery.of(context).size.width * 0.30,
                                height: 45,
                                hintText: 'Open',
                                controller: widget.controllers[i],
                                onTapped: () async {
                                  TimeOfDay time = widget.timeFrames[i];
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  TimeOfDay open = await showTimePicker(context: context, initialTime: time);
                                  if (open != null) {
                                    //TODO: if (widget.timeFrames[i-1] > open && widget.timeFrames[i+1] < open)
                                    setState(() {
                                      time = open;
                                      widget.controllers[i].text = open.format(context);
                                      widget.timeFrames[i] = open;
                                    }); //TODO: |else showDialog that says that new starting time has to be between those two values
                                  }
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('  -  ', style: TextStyle(fontSize: 30)),
                              SizedBox(
                                width: 15,
                              ),
                              FloatingTextField(
                                width: MediaQuery.of(context).size.width * 0.30,
                                height: 45,
                                hintText: 'Closed',
                                controller: widget.controllers[i + 1],
                                // add this line.
                                onTapped: () async {
                                  TimeOfDay time = widget.timeFrames[i + 1];
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  TimeOfDay closed = await showTimePicker(context: context, initialTime: time);
                                  //TODO: Same logic as open counterpart (remember that i is i+1 now)
                                  if (closed != null) {
                                    setState(() {
                                      time = closed;
                                      widget.controllers[i + 1].text = closed.format(context);
                                      widget.timeFrames[i + 1] = closed;
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.controllers.removeAt(i);
                                    widget.timeFrames.removeAt(i);
                                    widget.controllers.removeAt(i);
                                    widget.timeFrames.removeAt(i);
                                  });
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.add, size: 24, color: purpleAccent),
                      onPressed: () async {
                        TimeOfDay open = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now(), helpText: 'Choose the starting time for your new interval.');
                        /*int valid = -1;
                        if (widget.timeFrames.first > open)
                          valid = 0;
                        else if (widget.timeFrames.last < open)
                          valid = widget.timeFrames.length;
                        else
                          for (int i = 1; i < widget.timeFrames.length - 2; i + i + 2) {
                            if (widget.timeFrames[i] > open && widget.timeFrames[i + 1] < open) {
                              valid = i + 1;
                              break;
                            }
                          }
                        if (valid == -1) {
                          //showdialog that says starting time can't be between a current interval and to retry adding new interval
                        } else {*/
                        //show singleactionalert that tells person to chose ending time
                        TimeOfDay close = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now(), helpText: 'Choose the ending time for your new interval.');
                        //if (close > open && close < widget.timeFrames[valid])
                        setState(() {
                          /*widget.controllers.insert(valid, new TextEditingController(text: open.format(context)));
                          widget.controllers.insert(valid + 1, new TextEditingController(text: close.format(context)));
                          widget.timeFrames.insert(valid, open);
                          widget.timeFrames.insert(valid + 1, close);*/
                          widget.controllers.add(new TextEditingController(text: open.format(context)));
                          widget.controllers.add(new TextEditingController(text: close.format(context)));
                          widget.timeFrames.add(open);
                          widget.timeFrames.add(close);
                        }); //else showDialog that says that closing/ending time has to be greater than open.format(context) and less than the {next opening time}
                      },
                    )),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      DateTime now = new DateTime.now();
                      widget.temp[widget.date] = [];
                      for (TimeOfDay time in widget.timeFrames)
                        widget.temp[widget.date].add(new DateTime(now.year, now.month, now.day, time.hour, time.minute));
                      FirestoreHelper.getCurrentOrganizationReference(context).updateData({
                        'schedule': widget.temp,
                      }).then((value) => Navigator.pop(context));
                    },
                    child: Container(
                      height: 37,
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                        color: purpleAccent,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.edit, color: Colors.white, size: 25),
                              SizedBox(width: 2),
                              Text(
                                'Save Changes for ${widget.date}',
                                style: TextStyle(
                                  color: colorScheme.onSecondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
