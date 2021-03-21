import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: _value,
            items: [
              DropdownMenuItem(
                child: Text("Urgency"),
                value: 1,
              ),
              DropdownMenuItem(
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("Low"),
                    ],
                  ),
                ),
                value: 2,
              ),
              DropdownMenuItem(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text("Medium"),
                      ],
                    ),
                  ),
                  value: 3
              ),
              DropdownMenuItem(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text("High"),
                      ],
                    ),
                  ),
                  value: 4
              )
            ],
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            }),
      ),
    );
  }
}


