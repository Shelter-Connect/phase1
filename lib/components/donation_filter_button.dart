import 'package:flutter/material.dart';

import '../constants.dart';

class DonationFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFDEDEDE),
            blurRadius: 20.0,
            spreadRadius: 0.025,
            offset: Offset(
              0.0,
              0.0,
            ),
          ),
        ],
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Material(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text('Choose Filters', style: mainTitleStyle),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Choose Item Categories",
                            style: TextStyle(color: purpleAccent, fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Wrap(
                              spacing: 5.0,
                              runSpacing: 3.0,
                              children: <Widget>[
                                filterChipWidget(chipName: 'Hygiene'),
                                filterChipWidget(chipName: 'Food'),
                                filterChipWidget(chipName: 'Warmth'),
                                filterChipWidget(chipName: 'Utilities'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Choose Organization Categories',
                            style: TextStyle(color: purpleAccent, fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                children: <Widget>[
                                  filterChipWidget(chipName: 'Homeless Shelters'),
                                  filterChipWidget(chipName: 'Food Donation Centers'),
                                  filterChipWidget(chipName: 'Example: Pet Rescue'),
                                  filterChipWidget(chipName: 'Example: Special Needs'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              onPressed: () {
                                //TODO: Apply filters, delete unselected filters, send back to donation opportunities.
                              },
                              child: Container(
                                child: Text(
                                  'Apply Changes',
                                  style: TextStyle(color: purpleAccent, fontSize: 18.0, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: IntrinsicWidth(
          child: Row(
            children: <Widget>[
              Text('Filter', style: smallButtonStyle),
              SizedBox(width: 5.0),
              Column(
                children: [
                  SizedBox(height: 5.0),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: purpleAccent,
                    size: 30.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

// ignore: camel_case_types
class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: blueAccent, fontSize: 16.0, fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: colorScheme.background,
      onSelected: (isSelected) {
        setState(
          () {
            _isSelected = isSelected;
          },
        );
      },
      selectedColor: colorScheme.onSecondary,
    );
  }
}
