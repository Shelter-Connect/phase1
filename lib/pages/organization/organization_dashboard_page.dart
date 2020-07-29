import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/dashboard_slider_request_components.dart';
import 'package:phase1/components/dashboard_slider_tmr_components.dart';
import 'package:phase1/components/dashboard_slider_today_components.dart';
import 'package:phase1/components/text_button.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/request_slide_items.dart';
import 'package:phase1/models/todays_expected_slide_items.dart';
import 'package:phase1/models/tomorrows_expected_slide_items.dart';

import '../navigation_tab.dart';
import 'create_request_page.dart';
import 'expected_deliveries_page.dart';

class OrganizationDashboardPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationDashboardPageState createState() => _OrganizationDashboardPageState();

  @override
  String get helpDescription => 'you' 're bad kid omegalul git gud pepelaugh';

  /*'''  Hello, and welcome to the Organization Dashboard! In this page, you can get a quick glimpse of deliveries that volunteers have agreed to donate, also known as "Expected Deliveries."
  Current requests allow you to view the items that have not yet been claimed by a volunteer. You may edit those requests at any time.
  Have fun!
      ''';*/

  @override
  IconData get icon => Icons.home;

  @override
  String get title => 'Dashboard';

  @override
  Color get color => Colors.green;
}

class _OrganizationDashboardPageState extends State<OrganizationDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
              ),
              SizedBox(height: 20),
              Text(
                '# Expected Deliveries Today',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: purpleLight),
              ),
              SizedBox(height: 10),
              Container(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    CarouselSlider.builder(
                        itemCount: todaySlideList.length,
                        itemBuilder: (context, index) => SlideItem(index),
                        options: CarouselOptions(
                          height: 180.0,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.95,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '# Expected Deliveries Tomorrow',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: purpleLight),
              ),
              SizedBox(height: 10),
              Container(
                child: CarouselSlider.builder(
                    itemCount: tomorrowSlideList.length,
                    itemBuilder: (context, index) => TmrSlideItems(index),
                    options: CarouselOptions(
                      height: 180.0,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.95,
                    )),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  text: 'See all Expected Deliveries',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExpectedDeliveriesPage()),
                    );
                    //TODO: Make this button go to Expected Deliveries
                  },
                ),
              ),
              SizedBox(height: 5),
              Text(
                '# Current Requests',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: purpleLight),
              ),
              SizedBox(height: 10),
              Container(
                child: CarouselSlider.builder(
                    itemCount: requestSlideList.length,
                    itemBuilder: (context, index) => ReqSlideItems(index),
                    options: CarouselOptions(
                      height: 180.0,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.95,
                    )),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  text: 'See all Current Requests',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExpectedDeliveriesPage()),
                    );
                    //TODO: Make this button go to Expected Deliveries
                  },
                ),
              ),

//              DashboardComponent(
//                boxTitle: '# Expected Deliveries',
//                column: Column(
//                  children: <Widget>[
//                    DashboardButton(
//                      title: '6 blankets',
//                      color: colorScheme.onSecondary,
//                      onTap: () {
//                        //TODO: Make new page, which is Expected Deliveries - Extended
//                      },
//                      icon: Icon(
//                        Icons.arrow_right,
//                        size: 30,
//                      ),
//                    ),
//                    SizedBox(height: 5),
//                    DashboardButton(
//                      title: '3 sweaters',
//                      color: colorScheme.onSecondary,
//                      onTap: () {
//                        //TODO: Make new page, which is Expected Deliveries - Extended
//                      },
//                      icon: Icon(
//                        Icons.arrow_right,
//                        size: 30,
//                      ),
//                    ),
//                    SizedBox(height: 5),
//                    DashboardButton(
//                      title: '4 sweaters',
//                      color: colorScheme.onSecondary,
//                      onTap: () {
//                        //TODO: Make new page, which is Expected Deliveries - Extended
//                      },
//                      icon: Icon(
//                        Icons.arrow_right,
//                        size: 30,
//                      ),
//                    ),
//                    Align(
//                      alignment: Alignment.centerRight,
//                      child: TextButton(
//                        text: 'See all',
//                        onPressed: () {
//                          //TODO: Make this button go to Expected Deliveries
//                        },
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(height: 25),
//              DashboardComponent(
//                boxTitle: '# Current Requests',
//                height: 250,
//                column: Column(
//                  children: <Widget>[
//                    DashboardButton(
//                      title: '5 blankets',
//                      color: colorScheme.onSecondary,
//                      onTap: () {
//                        //TODO: Make new page, which is Expected Deliveries - Extended
//                      },
//                    ),
//                    SizedBox(height: 5),
//                    DashboardButton(
//                      title: '6 beans',
//                      color: colorScheme.onSecondary,
//                      onTap: () {
//                        //TODO: Make new page, which is Expected Deliveries - Extended
//                      },
//                    ),
//                    Align(
//                      alignment: Alignment.centerRight,
//                      child: TextButton(
//                        text: 'See all',
//                        onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => OrganizationExpectedDeliveriesPage()),
//                          );
//                          //TODO: Make this button go to Expected Deliveries
//                        },
//                      ),
//                    ),
//                  ],
//                ),
//              ),
              SizedBox(height: 75),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: purpleAccent,
        heroTag: 'create request',
        // Create request testing code
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRequestPage()),
          );
        },
        label: Text('New Request'),
        icon: Icon(
          Icons.edit,
          color: colorScheme.onSecondary,
        ),
      ),
    );
  }
}
