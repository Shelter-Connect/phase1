import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/constants.dart';
import '../../components/standard_layout.dart';
class OrganizationProfilePage extends StatefulWidget {
  @override
  _OrganizationProfilePageState createState() => _OrganizationProfilePageState();
}

class _OrganizationProfilePageState extends State<OrganizationProfilePage> {
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
                '(Organization Name)',
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Description',
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
                            Text('The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Address: 7213 City Street'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Website: cityteammens.org'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Phone Number: 408 131 4356'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Email: cityteammens@gmail.com'),
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
                            'Requested Items',
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
                            height: 20,
                          ),
                          Text('Hygiene', style: subHeaderStyle),
                          SizedBox(height: 5),
                          Text('Toothbrushes x 4'),
                          Text('Towels x 2'),
                          Text('Floss x 10'),
                          SizedBox(height: 20),
                          Text('Clothing', style: subHeaderStyle),
                          SizedBox(height: 5),
                          Text('Pair of Socks x 15'),
                          Text('T-shirt x 10'),
                          SizedBox(height: 20),
                          Text('Food', style: subHeaderStyle),
                          SizedBox(height: 5),
                          Text('Can of Beans x 4'),
                          Text('Whole Wheat Bread x 2'),
                          Text('Potatoes x 15'),
                          Text('Pizza x 4'),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RoundedButton(onPressed: (){
                Navigator.pushNamed(context, '/donate_page');
              }, title: 'Continue to Requests'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
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