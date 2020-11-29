import 'package:flutter/cupertino.dart';
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
    auth.onAuthStateChanged.listen(
      (user) {
        Provider.of<User>(context, listen: false).user = user;
        if (user != null) {
          db.collection('volunteers').document(user.uid).get().then(
            (value) {
              if (value.data != null) {
                if (user.isEmailVerified) {
                  Navigator.pushNamed(context, '/welcome');
                  Navigator.pushNamed(context, '/volunteer_navigation');
                } else {
                  Navigator.pushNamed(context, '/welcome');
                  Navigator.pushNamed(context, '/volunteer_confirmation');
                }
              }
            },
          );

          db.collection('organizations').document(user.uid).get().then(
            (value) {
              /*TimeOfDay open = TimeOfDay.now();
              TimeOfDay closed = open;
              Map<String, List<DateTime>> schedule = {
                'Monday': [new DateTime(1969, 1, 1, open.hour, open.minute), new DateTime(1969, 1, 1, closed.hour, closed.minute)],
                'Tuesday': [new DateTime(1969, 1, 1, open.hour, open.minute), new DateTime(1969, 1, 1, closed.hour, closed.minute)],
                'Wednesday': [new DateTime(1969, 1, 1, open.hour, open.minute), new DateTime(1969, 1, 1, closed.hour, closed.minute)],
                'Thursday': [new DateTime(1969, 1, 1, open.hour, open.minute), new DateTime(1969, 1, 1, closed.hour, closed.minute)],
                'Friday': [new DateTime(1969, 1, 1, open.hour, open.minute), new DateTime(1969, 1, 1, closed.hour, closed.minute)],
                'Saturday': [],
                'Sunday': [],
              };
              FirestoreHelper.getCurrentOrganizationReference(context).updateData({'schedule': schedule});*/
              if (value.data != null) {
                if (value['verified']) {
                  Navigator.pushNamed(context, '/welcome');
                  Navigator.pushNamed(context, '/organization_navigation');
                } else {
                  Navigator.pushNamed(context, '/welcome');
                  Navigator.pushNamed(context, '/organization_confirmation');
                }
              }
            },
          );
        } else {
          if (ModalRoute.of(context).isCurrent) {
            Navigator.pushNamed(context, '/welcome');
          } else {
            Navigator.popUntil(context, ModalRoute.withName('/welcome'));
          }
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo_svgs/Linkare_logo_purpleblack_transparent.png', width: MediaQuery.of(context).size.width * 0.30),
      ),
    );
  }
}
