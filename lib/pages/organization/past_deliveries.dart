import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phase1/components/expected_deliveries_container.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:provider/provider.dart';

import '../navigation_tab.dart';

class PastDeliveries extends StatefulWidget with NavigationTab {
  @override
  _PastDeliveriesState createState() => _PastDeliveriesState();

  @override
  String get helpDescription =>
      'This is your Current Requests page. Here, you can see items that you have requested that have not volunteers have not signed up for. '
      'To see items that volunteers have committed to, check the Expected Deliveries page.';

  @override
  Widget get icon =>
      SvgPicture.asset("assets/jam_icons/clock.svg", color: purpleAccent);

  @override
  Widget get activeIcon =>
      SvgPicture.asset("assets/jam_icons/clock-f.svg", color: purpleAccent);

  @override
  String get title => 'Past Deliveries';

  @override
  String get barTitle => 'Past Deliveries';
}

class _PastDeliveriesState extends State<PastDeliveries> {
  String dropdownValue = 'Sort by';
  List<Donation> donations;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Consumer<List<Donation>>(
            builder: (context, donations, widget) {
              this.donations = donations;
              if (donations == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (donations.length == 0) {
                return Column(
                  children: [
                    Text(
                      'Your organization currently does not have any expected deliveries.',
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
                          'assets/ui_svgs/dood.svg',
                          semanticsLabel: 'Create some requests!',
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                );
              }
              List<Widget> widgets = [];
              for (Donation donation in donations) {
                widgets.add(
                  ExpectedDeliveryContainer(
                    donation: donation,
                  ),
                );
                widgets.add(
                  SizedBox(height: 20.0),
                );
              }
              return Column(
                children: widgets,
              );
            },
          ),
        ],
      ),
    );
  }
}
