import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/pages/volunteer/organization_profile_page.dart';

import '../constants.dart';

class OrganizationDonationProfile extends StatelessWidget {
  final Organization organization;

  OrganizationDonationProfile({this.organization});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrganizationProfilePage(organization),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 7 / 10,
                        child: Text(
                          organization.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (organization.distance != null)
                    Text(
                      '${organization.distance.toStringAsFixed(1)} miles',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    organization.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (organization.itemCategories != null)
                    if (organization.itemCategories.length != 0)
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Looking to Receive:',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5.0),
                        Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: organization.itemCategories
                              .map(
                                (category) => Container(
                                  decoration: BoxDecoration(
                                    color: whiteBackground,
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    child: Text(
                                      category,
                                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ])
                ],
              ),
            ),
          ),
        ),
    );
  }
}






class ProfileDonation extends StatelessWidget {

  final Organization organization;

  ProfileDonation({this.organization});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: OpenContainer(
        closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        closedElevation: 1,
        closedColor: Color(0xFFF5F5F5),
        transitionDuration: Duration(milliseconds: 400),
        closedBuilder: (context, openWidget) {
          return RawMaterialButton(
            onPressed: openWidget,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 7 / 10,
                        child: Text(
                          organization.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (organization.distance != null)
                    Text(
                      '${organization.distance.toStringAsFixed(1)} miles',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    organization.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (organization.itemCategories != null)
                    if (organization.itemCategories.length != 0)
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Looking to Receive:',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5.0),
                        Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: organization.itemCategories
                              .map(
                                (category) => Container(
                              decoration: BoxDecoration(
                                color: whiteBackground,
                                borderRadius: BorderRadius.circular(21),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                child: Text(
                                  category,
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          )
                              .toList(),
                        ),
                      ])
                ],
              ),
            ),
          );
        },
        openBuilder: (context, closedWidget) {
          return OrganizationProfilePage(organization);
        },
      ),
    );
  }
}
