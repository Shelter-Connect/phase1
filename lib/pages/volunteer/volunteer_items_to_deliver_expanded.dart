import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import '../../components/standard_layout.dart';
import 'volunteer_items_to_deliver_page.dart';

class ItemsToDeliverExpanded extends StatefulWidget {
  @override
  _ItemsToDeliverExpandedState createState() => _ItemsToDeliverExpandedState();
}

class _ItemsToDeliverExpandedState extends State<ItemsToDeliverExpanded> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
        title: ' ',
        helpText: 'If u don\'t know how to use this app u stupid lmao',
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Text(
                  'Items to Deliver for (Organization Name)',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: Color(0xFF6576EC)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Text(
                  'Distance: (Distance away)',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(0xFF6576EC)),
                ),
              ),
              SizedBox(height: 20),
              FlatButton(
                  onPressed: () {
//TODO
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Selected Donations',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 5,
                                width: 100,
                                decoration: BoxDecoration(color: Color(0xFF6576EC), borderRadius: BorderRadius.circular(21)),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: colorScheme.error,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: FlatButton(
                                  onPressed: () {},
                                  child: Container(
                                      child: Text(
                                    'Edit Donations',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ItemsToDeliver('Blankets', 4),
                              SizedBox(
                                height: 2.5,
                              ),
                              ItemsToDeliver('Bananas', 15),
                              SizedBox(
                                height: 2.5,
                              ),
                              ItemsToDeliver('Can of Beans', 10),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(height: 20),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Organization Information ',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(color: Color(0xFF6576EC), borderRadius: BorderRadius.circular(21)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InfoText('loavesandfishes@gmail.com', '408-164-1745', '8164 Fish Pasta Dr.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}

class InfoText extends StatelessWidget {
  final String orgEmail;

  final String orgPhone;

  final String orgAddress;

  InfoText(this.orgEmail, this.orgPhone, this.orgAddress);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'Email Address: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )),
            TextSpan(
                text: orgEmail,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ))
          ]),
        ),
        FlatButton(
            onPressed: () {
              //TODO Redirect
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF6576EC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                child: Text('Open in Mail', style: TextStyle(fontSize: 15, color: colorScheme.background),),
              ),
            )),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'Phone Number: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )),
            TextSpan(
                text: orgPhone,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ))
          ]),
        ),
        FlatButton(
            onPressed: () {
              //TODO Redirect
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF6576EC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                child: Text('Call', style: TextStyle(fontSize: 15, color: colorScheme.background),),
              ),
            )),
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'Donation Location: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )),
            TextSpan(
                text: orgAddress,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ))
          ]),
        ),
        FlatButton(
            onPressed: () {
              //TODO Redirect
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF6576EC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                child: Text('Open in Maps', style: TextStyle(fontSize: 15, color: colorScheme.background),),
              ),
            )),
      ],
    );
  }
}
