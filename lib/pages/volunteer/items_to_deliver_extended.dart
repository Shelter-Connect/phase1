import 'package:flutter/material.dart';
import 'package:phase1/components/volunteer_organization_information_items_to_deliver_extended.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';
import 'volunteer_donate_page.dart';

class ItemsToDeliverExtended extends StatefulWidget {
  final String orgName;

  ItemsToDeliverExtended({this.orgName});
  @override
  _ItemsToDeliverExtendedState createState() => _ItemsToDeliverExtendedState();
}

class _ItemsToDeliverExtendedState extends State<ItemsToDeliverExtended> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
        title: ' ',
        helpText: 'If u don\'t know how to use this app u stupid lmao',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Items to Deliver for (Organization Name)',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
                ),
                Text(
                  'Distance: (Distance away)',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: purpleAccent),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(color: colorScheme.background, borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Selected Donations',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                FlatButton(
                                  padding: EdgeInsets.all(0.0),
                                  splashColor: transparent,
                                  highlightColor: transparent,
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: colorScheme.error,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerDonatePage()));
                                  },
                                ),
                              ],
                            ),
                            Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Blankets x4'),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text('Bananas x15'),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text('Can of Beans x10'),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                OrganizationInformation(orgEmail: 'waddap@gmail.com', orgPhone: '408 408 4080', orgAddress: '2914 Unicorn Drive')
              ],
            ),
          ),
        ));
  }
}


