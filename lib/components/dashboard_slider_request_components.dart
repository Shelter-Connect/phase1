import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/models/request_slide_items.dart';

import '../constants.dart';

class ReqSlideItems extends StatelessWidget {
  final int index;
  ReqSlideItems(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width / 2.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteBackground,
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
                            color: colorScheme.onBackground,
                          )),
                      TextSpan(
                          text: requestSlideList[index].userName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onBackground,
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
                            color: colorScheme.onBackground,
                          )),
                      TextSpan(
                          text: requestSlideList[index].userEmail,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onBackground,
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
                            color: colorScheme.onBackground,
                          )),
                      TextSpan(
                          text: requestSlideList[index].requestedDate,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onBackground,
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
                  Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(requestSlideList[index].itemName, style: subHeaderStyle),
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
