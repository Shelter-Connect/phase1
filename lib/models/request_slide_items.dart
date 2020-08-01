import 'package:flutter/material.dart';

class RequestSlide {
  final String userName;
  final String userEmail;
  final String requestedDate;
  final String itemName;
  final int itemAmount;
  final String requestMemo;

  RequestSlide({
    @required this.userName,
    @required this.userEmail,
    @required this.requestedDate,
    this.itemName,
    this.itemAmount,
    this.requestMemo,
  });
}

final requestSlideList = [
  RequestSlide(userEmail: 'hello@gmail.com', userName: 'Rick', requestedDate: '12/12', itemAmount: 5, itemName: 'Bananas'),
  RequestSlide(userEmail: 'hello@gmail.com', userName: 'Rick', requestedDate: '12/12', itemAmount: 5, itemName: 'Bananas'),
  RequestSlide(userEmail: 'hello@gmail.com', userName: 'Rick', requestedDate: '12/12', itemAmount: 5, itemName: 'Bananas'),
  RequestSlide(userEmail: 'hello@gmail.com', userName: 'Rick', requestedDate: '12/12', itemAmount: 5, itemName: 'Bananas'),
];
