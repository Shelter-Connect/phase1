import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            ),
          height: MediaQuery.of(context).size.height,
        ),
        Column(
          children: [
            Expanded(
              child: Image.asset('assets/logo_svgs/whitelogofinal2.png', width: 140),
              flex: 1,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Help out Non-Profit Organizations',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 28.0),
                color: Colors.transparent,
                child: Text(
                  'Welcome, and thank you so much for joining our community. We are thrilled to act as the connector between non-profit organizations and kind hearted people',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.symmetric(vertical: 18.0),
                constraints: BoxConstraints(
                  maxWidth: 330.0,
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: ButtonTheme(
                minWidth: 320.0,
                height: 50.0,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/organization_sign_up');
                  },
                  textColor: purpleAccent,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(side: BorderSide(
                      color: purpleAccent,
                      width: 1,
                      style: BorderStyle.solid
                  ), borderRadius: BorderRadius.circular(40)),
                  child: Container(
                    child: Text(
                      'Sign up as an Organization',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ButtonTheme(
                  minWidth: 320.0,
                  height: 50.0,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/volunteer_sign_up');
                    },
                    textColor: Colors.white,
                    color: purpleAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                    child: Container(
                      child: Text(
                        'Continue as a Volunteer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    textColor: Colors.white,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Existing User? Log In',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              flex: 0,
            ),
          ],
        ),
      ]),
    );
  }
}