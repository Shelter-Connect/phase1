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
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Donor: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: colorScheme.onBackground,
                          )),
                      TextSpan(
                          text: requestSlideList[index].userName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onBackground,
                          ))
                    ]),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
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
          ),

    );
  }
}
