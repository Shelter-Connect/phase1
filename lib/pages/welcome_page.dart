import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/pages/organization/organization_sign_up_page.dart';
import 'package:phase1/pages/volunteer/volunteer_sign_up_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/foodgivingsmaller.png',
              ),
            ),
          ),
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.grey.withOpacity(0.0),
                Colors.black,
                Colors.black,
                Colors.black,
              ],
              stops: [0.0, 0.6, 0.8, 1.0],
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: SvgPicture.asset('assets/logo_svgs/link.svg', //whitelogofinal2.png
                  width: 100, color: Colors.white70,),
              flex: 1,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Help out Non-Profit Organizations',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrganizationSignUpPage(),
                        ),
                      );},
                      textColor: purpleAccent,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      child: Container(
                        child: Text(
                          'Sign up as an Organization',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
              ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VolunteerSignUp(),
                      ),
                    );},
                    textColor: Colors.white,
                    color: purpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    child: Container(
                      child: Text(
                        'Sign up as a Volunteer',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
            ),
            SizedBox(height: 10),
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
