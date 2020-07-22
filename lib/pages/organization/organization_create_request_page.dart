import 'package:flutter/material.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/item_increment.dart';
import 'package:phase1/components/standard_layout_purple.dart';
import 'package:phase1/pages/organization/organization_select_item_page.dart';

import '../../components/category_icon_button.dart';

class OrganizationRequestPage extends StatefulWidget {
  @override
  _OrganizationRequestPageState createState() => _OrganizationRequestPageState();
}

class _OrganizationRequestPageState extends State<OrganizationRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'create request',
      child: StandardLayout2(
        title: 'Create Requests',
        helpText: '''   This is the Create Requests Page. Choose any category from which you would like to request and specify the amount desired. 
   You could also name a specific item from this page and specify the quantity desired.''',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Create Requests: ',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w900
                        )),
                    TextSpan(
                        text: 'Select Category',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ))
                  ]),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      CategoryIconButton(
                        asset: 'assets/hygiene_svgs/hygiene.svg',
                        name: 'Hygiene',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrganizationSelectItemPage(
                              categoryIcon: 'assets/hygiene_svgs/hygiene.svg',
                              categoryName: 'Hygiene',
                              items: {
                                'Body Soap': 'assets/hygiene_svgs/body_soap.svg',
                                'Nail Clipper': 'assets/hygiene_svgs/nail_clipper.svg',
                                'Soap': 'assets/hygiene_svgs/soap.svg',
                                'Toilet Paper': 'assets/hygiene_svgs/toilet_paper.svg',
                                'Toothbrush': 'assets/hygiene_svgs/toothbrush.svg',
                                'Toothpaste': 'assets/hygiene_svgs/toothpaste.svg',
                              },
                              categoryInfo: 'Hygiene is a very important part of a person\'s day. Staying clean is one way to brighten someone\'s day!')),
                          );
                        },
                      ),
                      CategoryIconButton(
                        asset: 'assets/clothing_svgs/clothes.svg',
                        name: 'Clothes',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrganizationSelectItemPage(
                                categoryIcon: 'assets/clothing_svgs/clothes.svg',
                                categoryName: 'Clothes',
                                items: {
                                  'Beanie': 'assets/clothing_svgs/beanie.svg',
                                  'Gloves': 'assets/clothing_svgs/gloves.svg',
                                  'Hats': 'assets/clothing_svgs/hats.svg',
                                  'Socks': 'assets/clothing_svgs/socks.svg',
                                  'Underwear': 'assets/clothing_svgs/underwear.svg',
                                  'Shirts': 'assets/clothing_svgs/shirt.svg',
                                },
                                categoryInfo: 'Clothes protect not only your body from physical harm, but strengthen your spirits and self-confidence.')),
                          );
                        },
                      ),
                      CategoryIconButton(
                        asset: 'assets/nutrition_svgs/nutrition.svg',
                        name: 'Nutrition',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrganizationSelectItemPage(
                                categoryIcon: 'assets/nutrition_svgs/nutrition.svg',
                                categoryName: 'Nutrition',
                                items: {
                                  'Beans': 'assets/nutrition_svgs/beans.svg',
                                  'Bread': 'assets/nutrition_svgs/bread.svg',
                                  'Eggs': 'assets/nutrition_svgs/eggs.svg',
                                  'Energy bars': 'assets/nutrition_svgs/energy_bar.svg',
                                  'Potatoes': 'assets/nutrition_svgs/potato.svg',
                                  'Water': 'assets/nutrition_svgs/water.svg',
                                },
                                categoryInfo: 'A healthy and filling meal, at times, is worth more than a million dollars.')),
                          );
                        },
                      ),
                      CategoryIconButton(
                        asset: 'assets/covid-19_response_svg/covid_19.svg',
                        name: 'COVID-19',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrganizationSelectItemPage(
                                categoryIcon: 'assets/covid-19_response_svg/covid_19.svg',
                                categoryName: 'COVID-19',
                                items: {
                                  'Face Shield': 'assets/covid-19_response_svg/face_shield.svg',
                                  'Hand Sanitizers': 'assets/covid-19_response_svg/hand_sanitizer.svg',
                                  'Latex Gloves': 'assets/covid-19_response_svg/latex_gloves.svg',
                                  'Masks': 'assets/covid-19_response_svg/mask.svg',
                                  'Wipes': 'assets/covid-19_response_svg/wipes.svg',
                                },
                                categoryInfo: 'Everyone deserves protection, especially in these trying times.')),
                          );
                        },
                      ),
                      CategoryIconButton(
                        asset: 'assets/warmth_svgs/warmth.svg',
                        name: 'Warmth',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrganizationSelectItemPage(
                                categoryIcon: 'assets/warmth_svgs/warmth.svg',
                                categoryName: 'Warmth',
                                items: {
                                  'Blankets': 'assets/warmth_svgs/blanket.svg',
                                  'Sleeping Bag': 'assets/warmth_svgs/sleeping_bag.svg',
                                  'Sleeping Pad': 'assets/warmth_svgs/sleeping_pad.svg',
                                },
                                categoryInfo: 'The need for warmth has been engraved into humans since the beginning of life, and has never disappeared')),
                          );
                        },
                      ),
                      CategoryIconButton(
                        asset: 'assets/other_svgs/other.svg',
                        name: 'Other',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrganizationSelectItemPage(
                                categoryIcon: 'assets/other_svgs/other.svg',
                                categoryName: 'Other',
                                items: {
                                },
                                categoryInfo: 'For people to live even at the bare minimum, they require more than the necessities')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                FloatingTextField(
                  hintText: 'Specific Item and/or Brand',
                  width: 225,
                  maxLines: 1,
                  //TODO Save Information to Firebase
                ),
                SizedBox(height: 20),
                ItemIncrementWithoutText(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
