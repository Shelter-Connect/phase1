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
                                // add this line.
                                onTapped: () async {
                                  TimeOfDay time = TimeOfDay.now();
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  TimeOfDay open = await showTimePicker(context: context, initialTime: time);
                                  if (open != null) {
                                    setState(() {
                                      time = open;
                                    });
                                    widget.controllers[i].text = open.format(context);
                                    widget.timeFrames[i] = open;
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
                                  TimeOfDay time = TimeOfDay.now();
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  TimeOfDay closed = await showTimePicker(context: context, initialTime: time);
                                  if (closed != null) {
                                    setState(() {
                                      time = closed;
                                    });
                                    widget.controllers[i + 1].text = closed.format(context);
                                    widget.timeFrames[i + 1] = closed;
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
                      onPressed: () {
                        TimeOfDay open = new TimeOfDay.now();
                        TimeOfDay close = new TimeOfDay.now();
                        setState(() {
                          widget.controllers.add(new TextEditingController(text: '${open.hour} : ${open.minute}'));
                          widget.controllers.add(new TextEditingController(text: '${close.hour} : ${close.minute}'));
                          widget.timeFrames.add(open);
                          widget.timeFrames.add(close);
                        });
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
                      }).then((value) => null);
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
