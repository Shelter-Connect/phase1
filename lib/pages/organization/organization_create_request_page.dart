import 'package:flutter/material.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/item_increment.dart';
import 'package:phase1/components/standard_layout_purple.dart';
import 'package:phase1/pages/organization/organization_create_request_choose_item.dart';

import '../../components/create_request_container.dart';

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
                      CreateRequestContainer(
                        asset: 'assets/hygiene_svgs/hygiene.svg',
                        name: 'Hygiene',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateRequestChooseItem(
                              categoryIcon: 'assets/hygiene_svgs/hygiene.svg',
                              categoryName: 'Hygiene',
                              name1: 'Body Soap',
                                name2: 'Nail Clippers',
                                name3: 'Soap',
                                name4: 'Toilet Paper',
                                name5: 'Toothbrush',
                                name6: 'Toothpaste',
                              itemIcons1: 'assets/hygiene_svgs/body_soap.svg',
                              itemIcons2: 'assets/hygiene_svgs/nail_clipper.svg',
                              itemIcons3: 'assets/hygiene_svgs/soap.svg',
                              itemIcons4: 'assets/hygiene_svgs/toilet_paper.svg',
                              itemIcons5: 'assets/hygiene_svgs/toothbrush.svg',
                              itemIcons6: 'assets/hygiene_svgs/toothpaste.svg',
                              categoryInfo: 'Hygiene is a very important part of a person\'s day. Staying clean is one way to brighten someone\'s day!')),
                          );
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/clothing_svgs/clothes.svg',
                        name: 'Clothes',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateRequestChooseItem(
                              categoryIcon: 'assets/clothing_svgs/clothes.svg',
                              categoryName: 'Clothes',
                              name1: 'Beanie',
                              name2: 'Gloves',
                              name3: 'Hats',
                              name4: 'Shirts',
                              name5: 'Socks',
                              name6: 'Underwear',
                              itemIcons1: 'assets/clothing_svgs/beanie.svg',
                              itemIcons2: 'assets/clothing_svgs/gloves.svg',
                              itemIcons3: 'assets/clothing_svgs/hats.svg',
                              itemIcons4: 'assets/clothing_svgs/shirt.svg',
                              itemIcons5: 'assets/clothing_svgs/socks.svg',
                              itemIcons6: 'assets/clothing_svgs/underwear.svg',
                              categoryInfo: 'Clothes protect not only your body from physical harm, but strengthen your spirits and self-confidence.',)),
                          );
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/nutrition_svgs/nutrition.svg',
                        name: 'Nutrition',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateRequestChooseItem(
                              categoryIcon: 'assets/nutrition_svgs/nutrition.svg',
                              categoryName: 'Nutrition',
                              name1: 'Beans',
                              name2: 'Bread',
                              name3: 'Eggs',
                              name4: 'Energy bars',
                              name5: 'Potatoes',
                              name6: 'Water',
                              itemIcons1: 'assets/nutrition_svgs/beans.svg',
                              itemIcons2: 'assets/nutrition_svgs/bread.svg',
                              itemIcons3: 'assets/nutrition_svgs/eggs.svg',
                              itemIcons4: 'assets/nutrition_svgs/energy_bar.svg',
                              itemIcons5: 'assets/nutrition_svgs/potato.svg',
                              itemIcons6: 'assets/nutrition_svgs/water.svg', categoryInfo: 'A healthy and filling meal, at times, is worth more than a million dollars.',)),
                          );
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/covid-19_response_svg/covid_19.svg',
                        name: 'COVID-19',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateRequestChooseItem(
                              categoryIcon: 'assets/covid-19_response_svg/covid_19.svg',
                              categoryName: 'COVID-19',
                              name1: 'Face Shield',
                              name2: 'Hand Sanitizers',
                              name3: 'Latex Gloves',
                              name4: 'Masks',
                              name5: 'Wipes',
                              name6: '',
                              itemIcons1: 'assets/covid-19_response_svg/face_shield.svg',
                              itemIcons2: 'assets/covid-19_response_svg/hand_sanitizer.svg',
                              itemIcons3: 'assets/covid-19_response_svg/latex_gloves.svg',
                              itemIcons4: 'assets/covid-19_response_svg/mask.svg',
                              itemIcons5: 'assets/covid-19_response_svg/wipes.svg',
                            itemIcons6: '',
                              categoryInfo: 'Everyone deserves protection, especially in these trying times.',)),
                          );
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/warmth_svgs/warmth.svg',
                        name: 'Warmth',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateRequestChooseItem(
                                categoryIcon: 'assets/warmth_svgs/warmth.svg',
                                categoryName: 'Warmth',
                                name1: 'Blankets',
                                name2: 'Sleeping Bag',
                                name3: 'Sleeping Pad',
                                name4: '',
                                name5: '',
                                name6: '',
                                itemIcons1: 'assets/warmth_svgs/blanket.svg',
                                itemIcons2: 'assets/warmth_svgs/sleeping_bag.svg',
                                itemIcons3: 'assets/warmth_svgs/sleeping_pad.svg',
                            itemIcons4: '',
                            itemIcons5: '',
                            itemIcons6: '', categoryInfo: 'The need for warmth has been engraved into humans since the beginning of life, and has never disappeared',)),
                          );
                        },
                      ),
                      CreateRequestContainer(
                        asset: 'assets/other_svgs/other.svg',
                        name: 'Other',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateRequestChooseItem(
                                categoryIcon: 'assets/other_svgs/other.svg',
                                categoryName: 'Other',
                              name1: '',
                              name2: '',
                              name3: '',
                              name4: '',
                              name5: '',
                              name6: '',
                              itemIcons1: '',
                              itemIcons2: '',
                              itemIcons3: '',
                              itemIcons4: '',
                              itemIcons5: '',
                              itemIcons6: '', categoryInfo: 'For people to live even at the bare minimum, they require more than the necessities',)),
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
