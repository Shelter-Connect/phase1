import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/constants.dart';

import '../navigation_tab.dart';

class PastDeliveries extends StatefulWidget with NavigationTab {
  @override
  _PastDeliveriesState createState() => _PastDeliveriesState();

  @override
  String get helpDescription =>
      'This is your Current Requests page. Here, you can see items that you have requested that have not volunteers have not signed up for. '
      'To see items that volunteers have committed to, check the Expected Deliveries page.';

  @override
  Widget get icon => SvgPicture.asset(
      "assets/jam_icons/clock.svg", color: purpleAccent);

  @override
  Widget get activeIcon => SvgPicture.asset(
      "assets/jam_icons/clock-f.svg", color: purpleAccent);

  @override
  String get title => 'History';

  @override
  String get barTitle => 'History';
}

class _PastDeliveriesState extends State<PastDeliveries>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
      child: Column(
        children: <Widget>[
//            Card(
//              child: ListTile(
//                title: const Text('Some information'),
//              ),
//            ),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
                color: purpleAccent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: TabBar(
              indicatorColor: Colors.white,
              unselectedLabelColor: darkPurpleAccent,
              labelColor: Colors.white,
              controller: _controller,
              tabs: [
                Tab(
                  icon: const Icon(Feather.gift),
                  text: 'Past Deliveries',
                ),
                Tab(
                  icon: const Icon(Feather.shopping_cart),
                  text: 'Past Requests',
                ),
              ],
            ),
          ),
          Material(
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [Text('Add de stuff')],
                      )),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [Text('Add de stuff')],
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
//            Card(
//              child: ListTile(
//                title: Text('Some more information'),
//              ),
//            ),
        ],
      ),
    );
  }
}
