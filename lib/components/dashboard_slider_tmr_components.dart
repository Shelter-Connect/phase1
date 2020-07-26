import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/models/tomorrows_expected_slide_items.dart';

import '../constants.dart';

class TmrSlideItems extends StatelessWidget {
  final int index;
  TmrSlideItems(this.index);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width / 2.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              color: Color(0xFFF7F7F7),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Donor: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                      TextSpan(
                          text: tomorrowSlideList[index].userName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ))
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Email: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                      TextSpan(
                          text: tomorrowSlideList[index].userEmail,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ))
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Expected: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                      TextSpan(
                          text: tomorrowSlideList[index].expectedDate,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ))
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text('Items', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),),
                  Row(
                    children: <Widget>[
                      Text(tomorrowSlideList[index].itemName, style: subHeaderStyle),
                      SizedBox(width: 20),
//                      Text(slideList[index].itemAmount, style: subHeaderStyle,),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}