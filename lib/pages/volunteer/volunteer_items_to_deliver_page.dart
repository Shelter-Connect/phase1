import 'package:flutter/material.dart';

import '../navigation_tab.dart';


class ItemsToDeliverPage extends StatefulWidget with NavigationTab {
  @override
  _ItemsToDeliverPageState createState() => _ItemsToDeliverPageState();

  @override
  String get helpDescription => 'This is a help description for the volunteer: items to deliver page';

  @override
  IconData get icon => Icons.home;

  @override
  String get title => 'Items To Deliver';
}

class _ItemsToDeliverPageState extends State<ItemsToDeliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAE5F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Text(
                'Items to Deliver',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: Color(0xFF6576EC)),
              ),
            ),
            SizedBox(height: 20),
            ItemsToDeliverBox('HomeFirst', 5.6),
            SizedBox(height: 15),
            ItemsToDeliverBox('City Team Men\'s Shelter', 1.8),
            SizedBox(height: 15),
            ItemsToDeliverBox('Loaves and Fishes', 2.6),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


class ItemsToDeliverBox extends StatefulWidget {

  final String orgName;

  final double orgMiles;

  ItemsToDeliverBox(this.orgName, this.orgMiles);

  @override
  _ItemsToDeliverBoxState createState() => _ItemsToDeliverBoxState();
}

class _ItemsToDeliverBoxState extends State<ItemsToDeliverBox> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/items_deliver_extended');
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10,),
                Row(
                  children: <Widget>[
                    Text(widget.orgName, style: TextStyle(
                      fontSize: 20,
                    ),),
                  ],
                ),
                SizedBox(height: 10,),
                Text('${widget.orgMiles} + miles away'),
                SizedBox(height: 5,),
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Color(0xFF6576EC),
                      borderRadius: BorderRadius.circular(21)
                  ),
                ),
                SizedBox(height: 10,),
                ItemsToDeliver('Blankets', 4),
                SizedBox(height: 5,),
                ItemsToDeliver('Bananas', 15),
                SizedBox(height: 5),
                ItemsToDeliver('Can of Beans', 10),
                SizedBox(height: 10),
              ],
            ),
          ),

        ));
  }
}

class ItemsToDeliver extends StatelessWidget {
  final String requestTitle;

  final int requestAmount;

  ItemsToDeliver(this.requestTitle, this.requestAmount);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      child: ListTile(
          trailing: Text('x $requestAmount'),
              title: Text(requestTitle),
      ),
    );
  }
}
