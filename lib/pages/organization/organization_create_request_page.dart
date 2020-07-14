import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/floating_text_field.dart';
import '../../components/create_request_container.dart';
import '../../components/standard_layout.dart';

class OrganizationRequestPage extends StatefulWidget {
  @override
  _OrganizationRequestPageState createState() => _OrganizationRequestPageState();
}

class _OrganizationRequestPageState extends State<OrganizationRequestPage> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'create request',
      child: StandardLayout(
        color: Color(0xff6474E1),
        title: 'Create Requests',
        helpText: '''   This is the Create Requests Page. Choose any category from which you would like to request and specify the amount desired. 
   You could also name a specific item from this page and specify the quantity desired.''',
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      CreateRequestContainer(
                        asset: 'assets/clean_hands-24px.svg',
                        name: 'Hygiene',
                        onPressed: () {
                          //TODO: Go to Hygiene Page
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/clothes.svg',
                        name: 'Clothing',
                        onPressed: () {
                          //TODO: Go to Hygiene Page
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/viburnum-fruit.svg',
                        name: 'Food',
                        onPressed: () {
                          //TODO: Go to Hygiene Page
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/water.svg',
                        name: 'Hydration',
                        fontSize: 23,
                        onPressed: () {
                          //TODO: Go to Hygiene Page
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/blanket.svg',
                        name: 'Warmth',
                        onPressed: () {
                          //TODO: Go to Hygiene Page
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: FloatingTextField(
                  width: 200,
                  hintText: 'Specific Brand/Model',
                ),
              ),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _itemCount != 0
                    ? new IconButton(
                  icon: new Icon(Icons.remove),
                  color: Colors.black,
                  onPressed: () => setState(() => _itemCount--),
                )
                    : Container(),
                SizedBox(width: 20),
                new Text(_itemCount.toString(), style: TextStyle(color: Colors.black)),
                SizedBox(width: 20),
                new IconButton(icon: new Icon(Icons.add, color: Colors.black), onPressed: () => setState(() => _itemCount++))
              ],
            ),
          ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
