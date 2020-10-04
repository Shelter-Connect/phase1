import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/user.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:phase1/pages/organization/create_request_page.dart';
import 'package:phase1/pages/organization/current_requests_page.dart';
import 'package:phase1/pages/organization/expected_deliveries_page.dart';
import 'package:phase1/pages/organization/organization_settings_page.dart';
import 'package:phase1/pages/organization/past_deliveries.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
//import '../feedback_form.dart';

class OrganizationNavigationPage extends StatefulWidget {
  @override
  _OrganizationNavigationPageState createState() => _OrganizationNavigationPageState();
}

class _OrganizationNavigationPageState extends State<OrganizationNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _tabs = [
    CurrentRequestsPage(),
    ExpectedDeliveriesPage(),
    PastDeliveries(),
//    FeedbackForm(),
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
                    Row(
                      children: [
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
                        IconButton(
                          icon: Icon(Feather.thumbs_up),
                          color: purpleAccent,
                          onPressed: () {
                            _helpModalBottomSheet2(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                _tabs[_selectedIndex],
              ],
            )),
          ),
          floatingActionButton: OpenContainer(
            closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
            transitionDuration: Duration(milliseconds: 200),
            closedBuilder: (context, openWidget) {
              return FloatingActionButton(
                backgroundColor: purpleAccent,
                child: Icon(Icons.add),
                onPressed: openWidget,
              );
            },
            openBuilder: (context, closedWidget) {
              return CreateRequestPage();
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height / 14 + 2,
            child: FABBottomAppBar(
              backgroundColor: Colors.white,
              //Colors.white
              iconSize: 25,
              color: purpleAccent,
              //remove color parameter
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
      ),
    );
  }

  void _helpModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
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

  void _helpModalBottomSheet2(BuildContext context) {
    TextEditingController bug = TextEditingController(), improvement = TextEditingController();
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Feedback', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Feather.thumbs_up),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      FloatingDescriptionField(
                        height: 150,
                        maxLength: 1500,
                        controller: bug,
                        maxLines: null,
                        labelText: ('Please report any bugs here.'),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        counterText: '',
                      ),
                      SizedBox(height: 20),
                      FloatingDescriptionField(
                        height: 150,
                        maxLength: 1500,
                        controller: improvement,
                        maxLines: null,
                        labelText: ('What do you think we can improve on?'),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        counterText: '',
                      ),
                      SizedBox(height: 20),
                      RoundedButton(
                        title: 'Submit Feedback',
                        onPressed: () {
                          db.collection('feedback').add(
                            {'bug': bug.text, 'improvement': improvement.text, 'email': Provider.of<User>(context, listen: false).user.email},
                          );
                          bug.clear();
                          improvement.clear();
                          FlushBar(message: 'Thank you for the feedback!', duration: Duration(seconds: 3)).build(context);
                        },
                        textColor: Colors.white,
                      )
                    ],
                  ),
                )
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
    assert(this.items.length == 3 || this.items.length == 4);
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
      return Expanded(
        child: _buildTabItem(
          item: widget.items[index],
          index: index,
          onPressed: _updateIndex,
        ),
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      notchMargin: 2.0,
      clipBehavior: Clip.antiAlias,
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
        child: ListView(
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
  //TODO Under here somewhere is where u gotta change for activeIcon to work. Probably

  Widget _buildTabItem({
    NavigationTab item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? colorScheme.onSecondary : widget.color; //purpleAccent instead of onSecondary
    return SizedBox(
      height: widget.height,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onPressed(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(child: item.icon,),
//              Icon(item.icon, color: color, size: widget.iconSize),
            ],
          ),
        ),
      ),
    );
  }
}
