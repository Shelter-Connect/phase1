import 'package:flutter/material.dart';

class TomorrowExpectedSlide {
  final String userName;
  final String userEmail;
  final String deliveryNotes;
  final String expectedDate;
  final String itemName;
  final int itemAmount;

  TomorrowExpectedSlide({
    @required this.userName,
    @required this.userEmail,
    this.deliveryNotes,
    @required this.expectedDate,
    this.itemName,
    this.itemAmount,
  });
}

final tomorrowSlideList = [
  TomorrowExpectedSlide(userEmail: 'hello@gmail.com', userName: 'Rick', expectedDate: '12/12',itemAmount: 5, itemName: 'Bananas'),
  TomorrowExpectedSlide(userEmail: 'hello@gmail.com', userName: 'Rick', expectedDate: '12/12', itemAmount: 5, itemName: 'Bananas'),
  TomorrowExpectedSlide(userEmail: 'hello@gmail.com', userName: 'Rick', expectedDate: '12/12',itemAmount: 5, itemName: 'Bananas'),
  TomorrowExpectedSlide(userEmail: 'hello@gmail.com', userName: 'Rick', expectedDate: '12/12', itemAmount: 5, itemName: 'Bananas'),
];
