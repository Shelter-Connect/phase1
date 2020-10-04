import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
  String get helpDescription => 'This is the Organization Discover page. Here, you can see nearby organizations in need of donations. '
      'To see more information about an organization, or to sign up for a donation, click on an organization. ';

  @override
  Widget get icon => SvgPicture.asset(
      "assets/jam_icons/compass.svg", color: purpleAccent);

  @override
  Widget get activeIcon => SvgPicture.asset(
      "assets/jam_icons/compass-f.svg", color: purpleAccent);

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
      throw new Error();
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
                    return Column(
                      children: [
                        Text(
                          'There are no organizations on the app yet, but please stick around! There are many organizations eager to start requesting!',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/ui_svgs/searching.svg',
                                semanticsLabel: 'Go Discover More Organizations to Help!',
                                width: MediaQuery.of(context).size.width,
                              ),
                            )),
                        SizedBox(height: 20),
                      ],
                    );
                  }
                  List<Widget> widgets = [];
                  Position userPosition = Provider.of<UserPosition>(context, listen: false).position;
                  for (Organization organization in organizations) {
                    if (organization.itemCategories != null && organization.itemCategories.length != 0) {
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
