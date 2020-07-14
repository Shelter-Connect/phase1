import 'package:flutter/material.dart';

import 'constants.dart';

class LoadingPage extends StatefulWidget {
  void firebasAuth(BuildContext context) {
    auth.onAuthStateChanged.listen((user) {
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
      } else
        Navigator.pushNamed(context, '/');
    });
  }

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    widget.firebasAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorScheme.surface,
    );
  }
}
