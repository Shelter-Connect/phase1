import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';

import '../../components/organization_donation_profile.dart';
import '../../constants.dart';
import '../navigation_tab.dart';

class OrganizationDiscover extends StatefulWidget with NavigationTab {
  @override
  _OrganizationDiscoverState createState() => _OrganizationDiscoverState();

  @override
  String get helpDescription => 'This is the Organization discover page. Here, you can see nearby organizations in need of donations. Your organization feed will be sorted from closest to farthest, and you can see the exact distance under each organization'
      '\'s name. Underneath the purple line, you can see a brief description, and the \"tags\" that summarize what type of donation the organization is requesting. '
      'To see more information about an organization, or to sign up for a donation, click on an organization. ';

  @override
  Widget get icon => Icon(Icons.delivery_dining, color: Color(0xFF6576EC));

  @override
  Widget get activeIcon => Icon(Icons.delivery_dining, color: Color(0xFF6576EC));

  @override
  String get title => 'Discover';

  @override
  String get barTitle => 'Linkare';
}

class _OrganizationDiscoverState extends State<OrganizationDiscover> {
  bool hasPosition = true;

  @override
  void initState() {
    LocationHelper.getUserPosition().then((position) {
      Provider.of<UserPosition>(context, listen: false).position = position;
    }).catchError((error) {
      if (Provider.of<UserPosition>(context, listen: false).position == null) {
        setState(() {
          hasPosition = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (Provider.of<UserPosition>(context).position == null && hasPosition)
            ? Center(child: CircularProgressIndicator())
            : Consumer<List<Organization>>(
                builder: (context, organizations, widget) {
                  if (organizations == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (organizations.length == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                      child: Column(
                        children: [
                          Text(
                            'There are no organizations on the app yet, but please stick around! There are many organizations eager to start requesting!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 40),
                          Center(
                            child: SvgPicture.asset(
                              'assets/ui_svgs/searching.svg',
                              semanticsLabel: 'Go Discover More Organizations to Help!',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  }
                  List<Widget> widgets = [];
                  Position userPosition = Provider.of<UserPosition>(context, listen: false).position;
                  for (Organization organization in organizations) {
                    if (organization.itemCategories != null && organization.itemCategories.length != 0 && organization.name != "Linkare Test Organization") {
                      organization.distance = userPosition != null
                          ? LocationHelper.distance(
                              organization.location.latitude, organization.location.longitude, userPosition.latitude, userPosition.longitude)
                          : null;
                      widgets.add(
                        ProfileDonation(organization: organization),
                      );
                    }
                  }
                  if (hasPosition) {
                    widgets.sort((a, b) {
                      return (a as ProfileDonation).organization.distance.compareTo((b as ProfileDonation).organization.distance);
                    });
                  }
                  for (int i = 1; i < widgets.length; i++) {
                    widgets.insert(
                      i++,
                      SizedBox(height: 5.0),
                    );
                  }
                  return Column(
                    children: widgets,
                  );
                },
              ),
        SizedBox(height: 20),
      ],
    );
  }
}
