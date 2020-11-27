import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/components/edit_hours_dates.dart';
import 'package:phase1/components/standard_layout.dart';

import '../../constants.dart';

class EditHoursWeekDay extends StatefulWidget {
  final String date;

  EditHoursWeekDay({@required this.date});

  @override
  _EditHoursWeekDayState createState() => _EditHoursWeekDayState();
}

class _EditHoursWeekDayState extends State<EditHoursWeekDay> {
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
                SizedBox(height: 10),
                EditHoursDate(),
                SizedBox(height: 10),
                EditHoursDate(),
                SizedBox(height: 10),
                EditHoursDate(),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      },
                    child: Container(
                      height: 37,
                      width: MediaQuery.of(context).size.width* 0.65,
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
                                'Update Hours for ${widget.date}', //TODO Change to : Update Business Hours
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
