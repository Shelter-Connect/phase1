import 'package:flutter/material.dart';
import 'package:phase1/components/rounded_button.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class DonationConfirmation extends StatefulWidget {
  @override
  _DonationConfirmationState createState() => _DonationConfirmationState();
}

class _DonationConfirmationState extends State<DonationConfirmation> {
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
                    padding: const EdgeInsets.symmetric(horizontal : 20.0, vertical: 4.0),
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
                              decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
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
                                onPressed: () {
                                  //TODO EDiT DONATIONS
                                },
                                child: Container(
                                    child: Text(
                                      'Edit Donations',
                                      style: TextStyle(color: colorScheme.onSecondary),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Blankets x4'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Bananas x15'),
                            SizedBox(
                              height: 5,
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
                              height: 10,
                            ),
                            Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RoundedButton(onPressed: (){
                  //TODO Update Firebase and input new order
                }, title: 'Confirm Donation Submission'),
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
                  color: colorScheme.onBackground,
                )),
            TextSpan(
                text: orgEmail,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onBackground,
                ))
          ]),
        ),
        FlatButton(
            onPressed: () {
              //TODO Redirect
            },
            child: Container(
              decoration: BoxDecoration(
                color: purpleAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                child: Text(
                  'Open in Mail',
                  style: TextStyle(fontSize: 15, color: colorScheme.background),
                ),
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
                  color: colorScheme.onBackground,
                )),
            TextSpan(
                text: orgPhone,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onBackground,
                ))
          ]),
        ),
        FlatButton(
            onPressed: () {
              //TODO Redirect
            },
            child: Container(
              decoration: BoxDecoration(
                color: purpleAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                child: Text(
                  'Call',
                  style: TextStyle(fontSize: 15, color: colorScheme.background),
                ),
              ),
            )),
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'Donation Location: ',
                style: TextStyle(
                  fontSize: 18,
                  color: colorScheme.onBackground,
                )),
            TextSpan(
                text: orgAddress,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onBackground,
                ))
          ]),
        ),
        FlatButton(
            onPressed: () {
              //TODO Redirect
            },
            child: Container(
              decoration: BoxDecoration(
                color: purpleAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                child: Text(
                  'Open in Maps',
                  style: TextStyle(fontSize: 15, color: colorScheme.background),
                ),
              ),
            )),
      ],
    );
  }
}
