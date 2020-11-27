import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/components/edit_hours_dates.dart';
import 'package:phase1/components/standard_layout.dart';

import '../../constants.dart';

class EditHoursSpecificDay extends StatefulWidget {
  final String date;

  EditHoursSpecificDay({@required this.date});

  @override
  _EditHoursSpecificDayState createState() => _EditHoursSpecificDayState();
}

class _EditHoursSpecificDayState extends State<EditHoursSpecificDay> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
        title: 'Edit Specific Day: ${widget.date}',
        titleColor: purpleAccent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                EditHoursDate(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}