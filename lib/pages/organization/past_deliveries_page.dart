import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phase1/models/past_donation.dart';
import 'package:provider/provider.dart';

import '../../components/delivery_containers.dart';
import '../../constants.dart';
import '../navigation_tab.dart';

class PastDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _PastDeliveriesPageState createState() => _PastDeliveriesPageState();

  @override
  String get helpDescription =>
      'This is the Past Deliveries page. Here, you can see any items that the volunteers have already delivered to your organization. At the top of each container, you '
          'can see the volunteer\'s name and the date of delivery. Underneath, you can see the name of the individual items, the quantity of the donation, and a specific description.'
  ;

  @override
  Widget get icon => SvgPicture.asset(
      "assets/jam_icons/clock.svg", color: purpleAccent);

  @override
  Widget get activeIcon => SvgPicture.asset(
      "assets/jam_icons/clock-f.svg", color: purpleAccent);

  @override
  String get title => 'Past Deliveries';

  @override
  String get barTitle => 'Past Deliveries';
}

class _PastDeliveriesPageState extends State<PastDeliveriesPage> {
  String dropdownValue = 'Sort by';
  List<PastDonation> donations;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<List<PastDonation>>(
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
                        'Your organization does not have any past deliveries.',
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
                for (PastDonation donation in donations) {
                  widgets.add(
                    PastDeliveryContainer(
                      donation: donation,
                    ),
                  );
                  widgets.add(
                    SizedBox(height: 5.0),
                  );
                }
                return Column(
                  children: widgets,
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
