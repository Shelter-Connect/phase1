import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/user.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:provider/provider.dart';

import '../../components/floating_text_field.dart';
import '../../components/geo_autocomplete.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';

class OrganizationEditInfoPage extends StatefulWidget {
  final Organization organization;

  OrganizationEditInfoPage(this.organization);
  @override
  _OrganizationEditInfoPageState createState() => _OrganizationEditInfoPageState();
}

class _OrganizationEditInfoPageState extends State<OrganizationEditInfoPage> {
  GeoPoint location;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  bool loading = false;

  @override
  void initState() {
    setState(() {
      location = GeoPoint(widget.organization.location.latitude, widget.organization.location.longitude);
      nameController.text = widget.organization.name;
      descriptionController.text = widget.organization.description;
      locationController.text = widget.organization.address;
      websiteController.text = widget.organization.website;
    });
    super.initState();
  }

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
                Text('Update Your Information', style: largeTitleStyle),
                SizedBox(height: 40),
                FloatingTextField(
                  hintText: 'Organization Name',
                  controller: nameController,
                  onChanged: (val) {
                    widget.organization.name = val.trim();
                  },
                ),
                SizedBox(height: 20),
                FloatingDescriptionField(
                  maxLength: 300,
                  controller: descriptionController,
                  onChanged: (val) {
                    setState(() {
                      widget.organization.description = val;
                    });
                  },
                  maxLines: null,
                  hintText: 'Short Description of Organization',
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  controller: locationController,
                  hintText: 'Organization Location',
                  onTapped: () async {
                    Prediction p =
                        await PlacesAutocomplete.show(context: context, apiKey: kGoogleApiKey, mode: Mode.overlay, controller: locationController);
                    locationController.value = TextEditingValue(
                      text: await displayPrediction(p),
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: 0),
                      ),
                    );
                  },
                  onChanged: (val) {
                    locationController.value = TextEditingValue(
                      text: val,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: 0),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  controller: websiteController,
                  onChanged: (val) {
                    setState(() {
                      widget.organization.website = val;
                    });
                  },
                  maxLines: null,
                  hintText: 'Website',
                ),
                SizedBox(height: 20),
                RoundedButton(
                  color: purpleAccent,
                  title: 'Edit Information',
                  textColor: Colors.white,
                  onPressed: () async {
                    await db.collection('organizations').document(widget.organization.id).updateData({
                      'description': widget.organization.description,
                      'name': widget.organization.name,
                      'location': location,
                      'address': locationController.text,
                      'website': widget.organization.website,
                    });
                  },
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    FirestoreHelper.resetPassword(Provider.of<User>(context, listen: false).user.email);
                    showDialog(
                      context: context,
                      builder: (_) => NoActionAlert(
                        title: 'Instructions to change your password have been sent to your email address.',
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 37,
                    decoration: BoxDecoration(
                      color: purpleAccent,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.edit, color: Colors.white, size: 25),
                          SizedBox(width: 2),
                          Text(
                            'Change Password',
                            style: TextStyle(
                              color: colorScheme.onSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
