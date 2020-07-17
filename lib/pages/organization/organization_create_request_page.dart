import 'package:flutter/material.dart';

import '../../components/create_request_container.dart';
import '../../components/standard_layout.dart';
import '../../constants.dart';

class OrganizationRequestPage extends StatefulWidget {
  @override
  _OrganizationRequestPageState createState() => _OrganizationRequestPageState();
}

class _OrganizationRequestPageState extends State<OrganizationRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'create request',
      child: StandardLayout(
        color: purpleAccent,
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
                        asset: 'assets/hygiene_svgs/hygiene.svg',
                        name: 'Hygiene',
                        onPressed: () {
                          //TODO: Go to Hygiene Page
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/clothing_svgs/clothes.svg',
                        name: 'Clothing',
                        onPressed: () {
                          //TODO: Go to Clothes Page
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/nutrition_svgs/nutrition.svg',
                        name: 'Nutrition',
                        onPressed: () {
                          //TODO: Go to Nutrition Page
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/covid-19_response_svg/covid_19.svg',
                        name: 'COVID-19',
                        onPressed: () {
                          //TODO: Go to COVID-19 Page
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/warmth_svgs/warmth.svg',
                        name: 'Warmth',
                        onPressed: () {
                          //TODO: Go to Warmth Page
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/more.svg',
                        name: 'Other',
                        onPressed: () {
                          //TODO: Go to Other Page
                        },
                      ),
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
