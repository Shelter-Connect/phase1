import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/user.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    auth.onAuthStateChanged.listen((user) {
      Provider.of<User>(context, listen: false).user = user;
      if (user != null) {
        db.collection('volunteers').document(user.uid).get().then((value) {
          if (value.data != null) {
            if (user.isEmailVerified) {
              Navigator.pushNamed(context, '/volunteer_navigation');
            } else {
              Navigator.pushNamed(context, '/volunteer_confirmation');
            }
          }
        });

        db.collection('organizations').document(user.uid).get().then((value) {
          if (value.data != null) {
            if (value['verified']) {
              Navigator.pushNamed(context, '/organization_navigation');
            } else {
              Navigator.pushNamed(context, '/organization_confirmation');
            }
          }
        });
      } else {
        if (ModalRoute.of(context).isCurrent) {
          Navigator.pushNamed(context, '/');
        }
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset('assets/ShelterConnectLogo.png', width: MediaQuery.of(context).size.width*0.6),
      ),
    );
  }
}