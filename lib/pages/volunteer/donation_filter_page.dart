import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

class DonationFilterPage extends StatefulWidget {
  @override
  _DonationFilterPageState createState() => _DonationFilterPageState();
}

class _DonationFilterPageState extends State<DonationFilterPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: colorScheme.error,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Filters",
          style: TextStyle(color: purpleAccent),
        ),
        actions: <Widget>[
          //TODO A button can be implemented if needed.
        ],
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Choose Item Categories",
                style: TextStyle(color: purpleAccent, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
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
              )),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Choose Organization Categories',
                style: TextStyle(color: purpleAccent, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
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
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: colorScheme.onSecondary,
    );
  }
}
