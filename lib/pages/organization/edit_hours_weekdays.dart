import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../constants.dart';

class EditHoursWeekDay extends StatefulWidget {
  final String day;
  final Map<String, List<TimeOfDay>> schedule;
  final List<TimeOfDay> timeFrames;
  final List<TextEditingController> controllers;
  final Map<String, List<DateTime>> temp = {};

  EditHoursWeekDay({@required this.day, @required this.timeFrames, @required this.schedule, @required this.controllers});

  @override
  _EditHoursWeekDayState createState() => _EditHoursWeekDayState();
}

class _EditHoursWeekDayState extends State<EditHoursWeekDay> {
  List<TimeOfDay> timeFrames;

  @override
  void initState() {
    setState(() {
      timeFrames = widget.timeFrames == null ? [] : widget.timeFrames;
    });
    widget.schedule[widget.day] = widget.timeFrames;
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
        title: 'Edit Hours: ${widget.day}',
        titleColor: purpleAccent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                if (widget.timeFrames.length == 0)
                  Text('Open for the Entire Day!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
                else
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
                                Spacer(),
                                FloatingTextField(
                                  width: MediaQuery.of(context).size.width * 0.22,
                                  height: 48,
                                  hintText: 'Open',
                                  controller: widget.controllers[i],
                                  onTapped: () async {
                                    TimeOfDay time = widget.timeFrames[i];
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    TimeOfDay open = await showTimePicker(context: context, initialTime: time);
                                    if (open != null) {
                                      if ((i != 0 ? timeOneGreater(open, widget.timeFrames[i - 1]) : true) &&
                                          timeOneGreater(widget.timeFrames[i + 1], open)) {
                                        setState(() {
                                          time = open;
                                          widget.controllers[i].text = open.format(context);
                                          widget.timeFrames[i] = open;

                                          print("EDITED OPENING TIME | Worked");
                                        });
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => NoActionAlert(
                                                title: "The new starting time ${open.format(context)} must be " +
                                                    (i != 0 ? "after ${widget.timeFrames[i - 1].format(context)} and " : "") +
                                                    "before ${widget.timeFrames[i + 1].format(context)}."));

                                        print("EDITED OPENING TIME | Failed");
                                      }
                                    } else {
                                      print("EDITING OPENING TIME | The user pressed 'Cancel'.");
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
                                  width: MediaQuery.of(context).size.width * 0.22,
                                  height: 48,
                                  hintText: 'Closed',
                                  controller: widget.controllers[i + 1],
                                  // add this line.
                                  onTapped: () async {
                                    TimeOfDay time = widget.timeFrames[i + 1];
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    TimeOfDay closed = await showTimePicker(context: context, initialTime: time);
                                    if (closed != null) {
                                      if (timeOneGreater(closed, widget.timeFrames[i]) &&
                                          (i + 2 < widget.timeFrames.length ? timeOneGreater(widget.timeFrames[i + 2], closed) : true)) {
                                        setState(() {
                                          time = closed;
                                          widget.controllers[i + 1].text = closed.format(context);
                                          widget.timeFrames[i + 1] = closed;
                                        });
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => NoActionAlert(
                                                title:
                                                    "The new closing time ${closed.format(context)} must be after ${widget.timeFrames[i].format(context)}" +
                                                        (i + 2 < widget.timeFrames.length
                                                            ? " and before ${widget.timeFrames[i + 2].format(context)}."
                                                            : ".")));
                                      }
                                    }
                                  },
                                ),
                                Spacer(),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.controllers.removeAt(i);
                                        widget.timeFrames.removeAt(i);
                                        widget.controllers.removeAt(i);
                                        widget.timeFrames.removeAt(i);
                                      });
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ),
                                Spacer()
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
                        // Add timeframe button
                        icon: Icon(Icons.add, size: 24, color: purpleAccent),
                        onPressed: () async {
                          TimeOfDay open = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now(), helpText: 'Choose the starting time for your new interval.');
                          if (open == null) return;
                          int validOpeningIndex = -1; // -1 is invalid, other values are index values (valid)
                          List<TimeOfDay> problematicTimeInterval = [];
                          Map<String, TimeOfDay> preexistingTimes = {}; // For if the new time matches an existing time
                          if (widget.timeFrames.isEmpty || timeOneGreater(widget.timeFrames.first, open)) { // Should work with an empty list as well
                            validOpeningIndex = 0;
                          } else if (timeOneGreater(open, widget.timeFrames.last)) {
                            validOpeningIndex = widget.timeFrames.length;
                          } else {
                            for (int i = 1; i < widget.timeFrames.length; i = i + 2) {
                              if (timeOneGreater(open, widget.timeFrames[i]) &&
                                  (i < widget.timeFrames.length - 1 ? timeOneGreater(widget.timeFrames[i + 1], open) : true)) {
                                validOpeningIndex = i + 1;
                                break;
                              } else if (timeOneGreater(open, widget.timeFrames[i - 1]) && timeOneGreater(widget.timeFrames[i], open)) {
                                problematicTimeInterval..add(widget.timeFrames[i - 1])..add(widget.timeFrames[i]);
                              } else if (open == widget.timeFrames[i-1] || open == widget.timeFrames[i]) { // If the new open time is same as an existing open time
                                preexistingTimes[open == widget.timeFrames[i-1] ? "open" : "close"] = open;
                              }
                            }
                          }

                          // Still on the added timeframe, but new if/else blocks, moving on to closing time now
                          if (validOpeningIndex == -1) { // If the starting time is invalid
                            showDialog(
                                context: context,
                                builder: (_) => NoActionAlert(
                                    title: preexistingTimes.isEmpty ?
                                        "The new starting time ${open.format(context)} cannot be between ${problematicTimeInterval[0].format(context)} and ${problematicTimeInterval[1].format(context)}. Try adding a new time." :
                                        "The new starting time ${open.format(context)} cannot match the existing " + (preexistingTimes.containsKey("open") ? "opening time ${preexistingTimes["open"].format(context)}." : "closing time ${preexistingTimes["close"].format(context)}."))
                                );
                          } else {
                            TimeOfDay close;
                            await showDialog(
                                context: context,
                                builder: (_) => SingleActionAlert(
                                    title: "Select Ending Time",
                                    subtitle: "Now please choose an ending time for this interval.",
                                    actionName: "Select",
                                    action: () async {
                                      close = await showTimePicker(
                                          context: context, initialTime: TimeOfDay.now(), helpText: 'Choose the ending time for your new interval.');

                                      if (timeOneGreater(close, open) &&
                                          (validOpeningIndex < widget.timeFrames.length - 1
                                              ? timeOneGreater(widget.timeFrames[validOpeningIndex], close)
                                              : true)) {
                                        setState(() {
                                          if (validOpeningIndex != widget.timeFrames.length) {
                                            widget.controllers.insert(validOpeningIndex, new TextEditingController(text: open.format(context)));
                                            widget.controllers.insert(validOpeningIndex + 1, new TextEditingController(text: close.format(context)));
                                            widget.timeFrames.insert(validOpeningIndex, open);
                                            widget.timeFrames.insert(validOpeningIndex + 1, close);
                                          } else {
                                            widget.controllers.add(new TextEditingController(text: open.format(context)));
                                            widget.controllers.add(new TextEditingController(text: close.format(context)));
                                            widget.timeFrames.add(open);
                                            widget.timeFrames.add(close);
                                          }
                                        }); //else showDialog that says that closing/ending time has to be greater than open.format(context) and less than the {next opening time}
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => NoActionAlert(
                                                title: "The new closing time ${close.format(context)} must be later than ${open.format(context)}" +
                                                    (validOpeningIndex + 1 < widget.timeFrames.length
                                                        ? " and earlier than ${widget.timeFrames[validOpeningIndex].format(context)}."
                                                        : ".")));
                                      }
                                    }));
                          }
                        })),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      DateTime now = new DateTime.now();
                      widget.temp[widget.day] = [];
                      for (TimeOfDay time in widget.timeFrames)
                        widget.temp[widget.day].add(new DateTime(now.year, now.month, now.day, time.hour, time.minute));
                      FirestoreHelper.getCurrentOrganizationReference(context).update({
                        'schedule': widget.temp,
                      }).then((value) => Navigator.pop(context));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: purpleAccent,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.edit, color: Colors.white, size: 25),
                            SizedBox(width: 2),
                            Text(
                              'Save Changes for ${widget.day}',
                              style: TextStyle(
                                color: colorScheme.onSecondary,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
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

bool timeOneGreater(TimeOfDay timeOne, TimeOfDay timeTwo) {
  // True if the first time is greater, false if not
  if (timeOne != null && timeTwo != null) {
    double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
    return toDouble(timeOne) > toDouble(timeTwo);
  } else {
    print("timeOneGreater(timeOne:timeTwo:) was passed one or more null values");
    return false;
  }
}
