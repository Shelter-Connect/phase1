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
              Navigator.pushNamed(context, '/welcome_updated');
              Navigator.pushNamed(context, '/volunteer_navigation');
            } else {
              Navigator.pushNamed(context, '/welcome_updated');
              Navigator.pushNamed(context, '/volunteer_confirmation');
            }
          }
        });

        db.collection('organizations').document(user.uid).get().then((value) {
          if (value.data != null) {
            if (value['verified']) {
              Navigator.pushNamed(context, '/welcome_updated');
              Navigator.pushNamed(context, '/organization_navigation');
            } else {
              Navigator.pushNamed(context, '/welcome_updated');
              Navigator.pushNamed(context, '/organization_confirmation');
            }
          }
        });
      } else {
        if (ModalRoute.of(context).isCurrent) {
          Navigator.pushNamed(context, '/welcome_updated');
        } else {
          Navigator.popUntil(context, ModalRoute.withName('/welcome_updated'));
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScheme.background,
      child: Center(
        child: Image.asset('assets/logo_svgs/ShelterConnectLogo.png', width: MediaQuery.of(context).size.width * 0.6),
      ),
    );
  }
}
