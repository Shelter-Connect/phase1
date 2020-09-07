import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();

  final Function onChanged;

  const DropDown({this.onChanged});
}

class _DropDownState extends State<DropDown> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: _value,
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "Urgency (Optional)",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                value: 1,
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(40)),
                    ),
                    SizedBox(width: 10),
                    Text("Low"),
                  ],
                ),
                value: 2,
              ),
              DropdownMenuItem(
                  child: Row(
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(40)),
                      ),
                      SizedBox(width: 10),
                      Text("Medium"),
                    ],
                  ),
                  value: 3),
              DropdownMenuItem(
                  child: Row(
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(40)),
                      ),
                      SizedBox(width: 10),
                      Text("High"),
                    ],
                  ),
                  value: 4)
            ],
            onChanged: (value) {
              setState(() {
                widget.onChanged(value);
                _value = value;
              });
            }),
      ),
    );
  }
}
