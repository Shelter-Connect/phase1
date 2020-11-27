import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/standard_layout.dart';

import '../../constants.dart';

class EditHoursWeekDay extends StatefulWidget {
  final String date;
  List<TimeOfDay> timeFrames;

  EditHoursWeekDay({@required this.date, @required this.timeFrames});

  @override
  _EditHoursWeekDayState createState() => _EditHoursWeekDayState();
}

class _EditHoursWeekDayState extends State<EditHoursWeekDay> {
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    if (widget.timeFrames == null) widget.timeFrames = [];
    for (TimeOfDay time in widget.timeFrames)
      controllers.add(
          new TextEditingController(text: '${time.hour} : ${time.minute}'));
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
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 45,
                                hintText: 'Open',
                                controller: controllers[i],
                                // add this line.
                                onTapped: () async {
                                  TimeOfDay time = TimeOfDay.now();
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay open = await showTimePicker(
                                      context: context, initialTime: time);
                                  if (open != null) {
                                    setState(() {
                                      time = open;
                                    });
                                    controllers[i].text =
                                        open.format(context);
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
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 45,
                                hintText: 'Closed',
                                controller: controllers[i+1],
                                // add this line.
                                onTapped: () async {
                                  TimeOfDay time = TimeOfDay.now();
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay closed = await showTimePicker(
                                      context: context, initialTime: time);
                                  if (closed != null) {
                                    setState(() {
                                      time = closed;
                                    });
                                    controllers[i+1].text =
                                        closed.format(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 37,
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                        color: purpleAccent,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.edit, color: Colors.white, size: 25),
                              SizedBox(width: 2),
                              Text(
                                'Update Hours for ${widget.date}',
                                //TODO Change to : Update Business Hours
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
