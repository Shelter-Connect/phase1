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
                        CreateRequestContainer(name: 'Body Soap', asset: 'assets/hygiene_svgs/body_soap.svg', onPressed: (){},),
                        CreateRequestContainer(name: 'Nail Clipper', asset: 'assets/hygiene_svgs/nail_clipper.svg', onPressed: (){},),
                        CreateRequestContainer(name: 'Soap', asset: 'assets/hygiene_svgs/soap.svg', onPressed: (){},),
                        CreateRequestContainer(name: 'Toilet Paper', asset: 'assets/hygiene_svgs/toilet_paper.svg', onPressed: (){},),
                        CreateRequestContainer(name: 'Tooth Brush', asset: 'assets/hygiene_svgs/toothbrush.svg', onPressed: (){},),
                        CreateRequestContainer(name: 'Tooth Paste', asset: 'assets/hygiene_svgs/toothpaste.svg', onPressed: (){},),
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


