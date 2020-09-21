import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:phase1/pages/organization/create_request_page.dart';
import 'package:phase1/pages/organization/current_requests_page.dart';
import 'package:phase1/pages/organization/expected_deliveries_page.dart';
import 'package:phase1/pages/organization/organization_settings_page.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';

import '../../constants.dart';
import '../feedback_form.dart';

class OrganizationNavigationPage extends StatefulWidget {
  @override
  _OrganizationNavigationPageState createState() => _OrganizationNavigationPageState();
}

class _OrganizationNavigationPageState extends State<OrganizationNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _tabs = [
    CurrentRequestsPage(),
    ExpectedDeliveriesPage(),
    FeedbackForm(),
    OrganizationSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Donation>>.value(
          value: FirestoreHelper.getCurrentOrganizationReference(context).collection('currentDonations').orderBy('date').snapshots().map((snapshot) {
            if (snapshot.documents.length == 0) return [];
            if (snapshot == null) return null;
            List<Donation> donations = [];
            for (DocumentSnapshot document in snapshot.documents) {
              donations.add(Donation.fromFirestoreMap(document));
            }
            return donations;
          }),
        ),
        StreamProvider<QuerySnapshot>.value(
          value: FirestoreHelper.getCurrentOrganizationReference(context).collection('requests').snapshots(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Color(0xfff5f5f5),
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 4.0, top: 8.0),
                        child: Text(_tabs[_selectedIndex].barTitle, style: appBarTitleStyle),
                      ),
                    ),
                    Visibility(
                      visible: _tabs[_selectedIndex].helpDescription != '',
                      child: IconButton(
                        icon: Icon(Icons.help),
                        color: purpleAccent,
                        onPressed: () {
                          _helpModalBottomSheet(context);
                        },
                      ),
                    ),
                  ],
                ),
                _tabs[_selectedIndex],
              ],
            )),
          ),
          floatingActionButton: OpenContainer(
            closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            transitionDuration: Duration(milliseconds: 200),closedBuilder: (context,openWidget){
            return FloatingActionButton(backgroundColor: purpleAccent,
              child: Icon(Icons.add),
              onPressed: openWidget,);}, openBuilder: (context,closedWidget){
              return CreateRequestPage();
                },),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: FABBottomAppBar(
            backgroundColor: Colors.white,
            iconSize: 25,
            notchedShape: CircularNotchedRectangle(),

            items: _tabs,
            onTabSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  void _helpModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Help', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.help),
                      ),
                    ],
                  ),
                ),
                Text(_tabs[_selectedIndex].helpDescription, style: TextStyle(fontSize: 17)),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<NavigationTab> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    NavigationTab item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? purpleAccent : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.icon, color: color, size: widget.iconSize),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

