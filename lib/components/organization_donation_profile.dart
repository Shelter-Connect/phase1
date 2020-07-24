import 'package:flutter/material.dart';
import 'package:phase1/pages/volunteer/organization_profile_page.dart';

import '../constants.dart';

class OrganizationDonationProfile extends StatelessWidget {
  final String name, description, organizationId;
  final double distance;
  final List<String> itemCategories;

  OrganizationDonationProfile({this.name, this.distance, this.description, this.itemCategories, this.organizationId});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrganizationProfilePage(
                      name: name,
                      description: description,
                      distance: distance,
                      organizationId: organizationId,
                    )),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.circular(20.0)),
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
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        //TODO
                      },
                    ),
                  ),
                ],
              ),
              Text(
                '${distance.toStringAsFixed(1)} miles',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
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
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
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
                children: itemCategories
                    .map((category) => Container(
                          decoration: BoxDecoration(
                            color: whiteBackground,
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: colorScheme.secondaryVariant,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
