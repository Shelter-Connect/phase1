import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/user.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:provider/provider.dart';

import '../../components/floating_text_field.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';

class VolunteerEditInfoPage extends StatefulWidget { //TODO ADD EDit Functionality Backend

  @override
  _VolunteerEditInfoPageState createState() => _VolunteerEditInfoPageState();
}

class _VolunteerEditInfoPageState extends State<VolunteerEditInfoPage> {
  Organization organization;
  GeoPoint location;
  TextEditingController nameController = TextEditingController();

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  bool loading = false;

//  @override
//  void initState() {
//    setState(() {
//      organization = widget.organization.clone();
//      location = GeoPoint(organization.location.latitude, organization.location.longitude);
//      nameController.text = organization.name;
//    });
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: 'Update Your Information',
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
                Text('Change Your Name', style: largeTitleStyle),
                SizedBox(height: 40),
                FloatingTextField(
                  hintText: 'Your Name',
                  controller: nameController,
                  onChanged: (val) {
                    organization.name = val.trim();
                  },
                ),
                SizedBox(height: 20),
                RoundedButton(
                  onPressed: () {
                    FirestoreHelper.resetPassword(Provider.of<User>(context, listen: false).user.email);
                    showDialog(
                      context: context,
                      builder: (_) => NoActionAlert(
                        title: 'Instructions to change your password have been sent to your email address.',
                      ),
                    );
                  },
                  title: 'Reset Password',
                  color: purpleAccent,
                  textColor: Colors.white,
                ),
                RoundedButton(
                  color: purpleAccent,
                  title: 'Update Name',
                  textColor: Colors.white,
                  onPressed: () {
                    db.collection('organizations').document(organization.id).updateData({
                      'name': organization.name,
                    });
                    Navigator.pop(context, true);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Your name has been updated.'),
                    ));
                  },
                ),
                SizedBox(height: 10.0),
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
      location = GeoPoint(detail.result.geometry.location.lat, detail.result.geometry.location.lng);
      return detail.result.formattedAddress;
    }
    return '';
  }
}
