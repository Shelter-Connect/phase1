import 'package:flutter/material.dart';

import '../constants.dart';

class MapSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showDirections(
                        destination: coords,
                        destinationTitle: title,
                      ),
                      title: Text(map.mapName),
                      leading: Image(
                        image: map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
