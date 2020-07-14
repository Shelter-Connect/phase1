import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

class ShelterDonationProfile extends StatelessWidget {
  final String orgName;

  final double orgMiles;

  final String orgDescription;

  ShelterDonationProfile(this.orgName, this.orgMiles, this.orgDescription);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/org_profile');
        },
        child: Container(
          decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      orgName,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        //TODO
                      },
                    ),
                  ],
                ),
                Text('$orgMiles + miles away'),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  orgDescription,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'Roboto',
                    color: new Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Looking to Receive',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
                        child: Text('Hygiene',
                            style: TextStyle(
                              color: colorScheme.secondaryVariant,
                            )),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
                        child: Text('Food',
                            style: TextStyle(
                              color: colorScheme.secondaryVariant,
                            )),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
                        child: Text('Warmth',
                            style: TextStyle(
                              color: colorScheme.secondaryVariant,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
