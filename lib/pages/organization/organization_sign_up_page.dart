import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../components/alerts.dart';
import '../../components/floating_text_field.dart';
import '../../components/geo_autocomplete.dart';
import '../../components/rounded_button.dart';
import '../../components/text_button.dart';
import '../../constants.dart';

class OrganizationSignUpPage extends StatefulWidget {
  @override
  _OrganizationSignUpPageState createState() => _OrganizationSignUpPageState();
}

class _OrganizationSignUpPageState extends State<OrganizationSignUpPage> {
  String email = '', password = '', password2 = '', organizationName = '', description = '', number, website;
  GeoPoint location;
  TextEditingController controller = TextEditingController();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Text('Organization Sign Up', style: largeTitleStyle),
                SizedBox(height: 40),
                FloatingTextField(
                  hintText: 'Organization Name',
                  onChanged: (val) {
                    organizationName = val.trim();
                  },
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Organization Email',
                  onChanged: (val) {
                    email = val.trim();
                  },
                ),
                SizedBox(height: 20),
                FloatingDescriptionField(
                  maxLength: 300,
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                  maxLines: null,
                  hintText: 'Short Description of Organization',
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  controller: controller,
                  hintText: 'Organization Address',
                  onTapped: () async {
                    Prediction p = await PlacesAutocomplete.show(context: context, apiKey: kGoogleApiKey, mode: Mode.overlay, controller: controller);
                    if (p != null)
                      controller.value = TextEditingValue(
                        text: await displayPrediction(p),
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: 0),
                        ),
                      );
                  },
                  onChanged: (val) {
                    controller.value = TextEditingValue(
                      text: val,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: 0),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  onChanged: (val) {
                    setState(() {
                      website = val;
                    });
                  },
                  maxLines: null,
                  hintText: 'Website (Optional)',
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  obscureText: true,
                  hintText: 'Password',
                  onChanged: (val) {
                    password = val.trim();
                  },
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  obscureText: true,
                  hintText: 'Re-enter Password',
                  onChanged: (val) {
                    password2 = val.trim();
                  },
                ),
                SizedBox(height: 20),
                RoundedButton(
                  color: purpleAccent,
                  title: 'Create Account',
                  textColor: Colors.white,
                  onPressed: () async {
                    if (organizationName == '') {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Please enter an organization name'),
                      );
                    } else if (email == '') {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Please enter an email'),
                      );
                    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
                      //is valid email address
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Please enter a valid email address.'),
                      );
                    } else if (description == '') {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Please enter a description'),
                      );
                    } else if ((controller.text == '') || (controller.text == null)) {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Please enter the location of your organization'),
                      );
                    } else if (password == '') {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Please enter a password'),
                      );
                    } else if (password2 == '') {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Please enter your password a second time'),
                      );
                    } else if (password != password2) {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Passwords needs to be at least 6 characters in length'),
                      );
                    } else if (password.length < 6) {
                      showDialog(
                        context: context,
                        builder: (_) => NoActionAlert(title: 'Passwords do not match'),
                      );
                    } else {
                      try {
                        setState(() {
                          loading = true;
                        });
                        final newUser = await auth.createUserWithEmailAndPassword(email: email, password: password);
                        setState(() {
                          loading = false;
                        });
                        if (newUser != null) {
                          await db.collection('organizations').document(newUser.user.uid).setData({
                            'description': description,
                            'email': email,
                            'name': organizationName,
                            'location': location,
                            'address': controller.text,
                            'verified': false,
                            'number': number,
                            'website': website,
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => NoActionAlert(title: 'Email already taken'),
                          );
                        }
                        FocusScope.of(context).unfocus();
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (_) => NoActionAlert(title: 'Email already taken'),
                        );
                      }
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextButton(
                    text: 'Not an Organization?',
                    textColor: purpleAccent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

      //var placeId = p.placeId;
      //var address = await Geocoder.local.findAddressesFromQuery(p.description);
      location = new GeoPoint(detail.result.geometry.location.lat, detail.result.geometry.location.lng);
      return detail.result.formattedAddress;
    }
    return '';
  }
}
