import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phase1/components/requests_container.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:provider/provider.dart';

import '../navigation_tab.dart';
import 'edit_current_requests_page.dart';

class CurrentRequestsPage extends StatefulWidget with NavigationTab {
  @override
  _CurrentRequestsPageState createState() => _CurrentRequestsPageState();

  @override
  String get helpDescription =>
      'This is your Current Requests page. Here, you can see items that you have requested that have not volunteers have not signed up for. '
      'To see items that volunteers have committed to, check the Expected Deliveries page.';

  @override
  Widget get icon => SvgPicture.asset(
      "assets/jam_icons/task-list.svg", color: Colors.white);

  @override
  Widget get activeIcon => SvgPicture.asset(
      "assets/jam_icons/task-list-f.svg", color: Colors.white);

  @override
  String get title => 'Requests';

  @override
  String get barTitle => 'Current Requests';
}

class _CurrentRequestsPageState extends State<CurrentRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: OpenContainer(
                  closedShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  closedColor: Color(0xfff5f5f5),
                  closedElevation: 0,
                  transitionDuration: Duration(milliseconds: 190),
                  closedBuilder: (context, openWidget) {
                    return FlatButton(
                      onPressed: openWidget,
                      color: purpleAccent,
                      padding: EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            Text('Edit',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))
                          ],
                        ),
                      ),
                    );
                  },
                  openBuilder: (context, closedWidget) {
                    return EditCurrentRequestsPage();
                  },
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 3),
            ],
          ),
          SizedBox(height: 10),
          Consumer<QuerySnapshot>(
            builder: (context, snapshot, widget) {
              if (snapshot == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.documents.length == 0) {
                return Column(
                  children: [
                    Text(
                      'Your organization currently does not have any requests. Create a request with the \'New Request\' button at the bottom.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/ui_svgs/shopping.svg',
                          semanticsLabel: 'Create an Item Request!',
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                );
              }
              Map<String, List<Item>> itemCategories = {};
              for (DocumentSnapshot document in snapshot.documents) {
                if (!itemCategories.containsKey(document['category'])) {
                  itemCategories[document['category']] = [];
                }
                itemCategories[document['category']].add(
                  Item(
                      name: document['name'],
                      category: document['category'],
                      amount: document['amount'],
                      specificDescription: document['specificDescription'],
                      unit: document['unit'],
                      urgency: document['urgency'],
                      urgencyColor: (document['urgency'] == 0)
                          ? Colors.transparent
                          : (document['urgency'] == 1)
                              ? Colors.green
                              : (document['urgency'] == 2)
                                  ? Colors.yellow
                                  : Colors.red),
                );
              }

              List<Widget> requestContainers = [];
              for (String category in itemCategories.keys) {
                requestContainers.add(
                  RequestContainer(
                    items: itemCategories[category],
                    category: category,
                  ),
                );
              }
              return Column(
                children: requestContainers,
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
