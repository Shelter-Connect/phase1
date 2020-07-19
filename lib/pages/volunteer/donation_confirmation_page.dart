import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/pages/volunteer/volunteer_donate_page.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class DonationConfirmationPage extends StatefulWidget {
  @override
  _DonationConfirmationPageState createState() => _DonationConfirmationPageState();
}

class _DonationConfirmationPageState extends State<DonationConfirmationPage> {
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
                  'Confirm Donations for (Organization Name)',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Text(
                  'Distance: (Distance away)',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: purpleAccent),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(color: colorScheme.background, borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Selected Donations',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  child: FlatButton(
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
                                ),
                              ],
                            ),
                            Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Blankets x 4', style: TextStyle(fontSize: 17)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Bananas x 15', style: TextStyle(fontSize: 17)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Can of Beans x 10', style: TextStyle(fontSize: 17)),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(color: colorScheme.background, borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              height: 5,
                            ),
                            Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InfoText(orgEmail: 'loavesandfishes@gmail.com', orgPhone: '408-164-1745', orgAddress: '8164 Fish Pasta Dr.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    onPressed: () {
                      //TODO Update Firebase and input new order
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: purpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                      child: Text(
                        'Confirm Donation Submission',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10)
            ],
          ),
        ));
  }
}

class InfoText extends StatelessWidget {
  final String orgEmail;

  final String orgPhone;

  final String orgAddress;

  InfoText({this.orgEmail, this.orgPhone, this.orgAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(text: 'Email Address: ', style: TextStyle(fontSize: 17, color: Colors.black)),
            TextSpan(text: orgEmail, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black))
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(text: 'Phone Number: ', style: TextStyle(fontSize: 17, color: Colors.black)),
            TextSpan(text: orgPhone, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black))
          ]),
        ),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(text: 'Donation Location: ', style: TextStyle(fontSize: 17, color: Colors.black)),
            TextSpan(text: orgAddress, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black))
          ]),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
