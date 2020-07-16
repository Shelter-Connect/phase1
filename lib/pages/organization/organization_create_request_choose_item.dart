import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/create_request_container.dart';

import '../../components/standard_layout_purple.dart';


class CreateRequestChooseItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardLayout2(
        title: '',
        helpText: 'Hello, i will not help you',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Create Requests',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric( vertical: 16),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        CreateRequestContainer(name: 'Soap', asset: 'assets/soap.svg', onPressed: (){},),
                        CreateRequestContainer(name: 'Blanket', asset: 'assets/blanket.svg', onPressed: (){},),
                        CreateRequestContainer(name: 'Clothes', asset: 'assets/clothes.svg', onPressed: (){},),
                        CreateRequestContainer(name: 'Water', asset: 'assets/water.svg', onPressed: (){},),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

class ItemBox extends StatelessWidget {
  final String itemName;
  final String iconFile;

  ItemBox({this.itemName, this.iconFile});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width / 4,
              width: MediaQuery.of(context).size.width / 4,
              child: Text('hello'),
            ),
              Text(itemName),
            ],
          ),
        )
      ),
    );
  }
}


