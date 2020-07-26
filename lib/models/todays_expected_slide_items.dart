import 'package:flutter/material.dart';

class TodayExpectedSlide {
  final String userName;
  final String userEmail;
  final String expectedDate;
  final String itemName;
  final int itemAmount;

  TodayExpectedSlide({
    @required this.userName,
    @required this.userEmail,
    @required this.expectedDate,
    this.itemName,
    this.itemAmount,
  });
}

final todaySlideList = [
  TodayExpectedSlide(userEmail: 'shelterconnect20@gmail.com', userName: 'Rick', expectedDate: '12/12', itemAmount: 5, itemName: 'Bananas'),
  TodayExpectedSlide(userEmail: 'hello@gmail.com', userName: 'Rick', expectedDate: '12/12', itemAmount: 5, itemName: 'Bananas'),
  TodayExpectedSlide(userEmail: 'hello@gmail.com', userName: 'Rick', expectedDate: '12/12', itemAmount: 5, itemName: 'Bananas'),
  TodayExpectedSlide(userEmail: 'hello@gmail.com', userName: 'Rick', expectedDate: '12/12',  itemAmount: 5, itemName: 'Bananas'),
];
