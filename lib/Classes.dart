import 'package:flutter/material.dart';
import 'dart:ffi';

var url='http://192.168.43.61:8000/vendor';

class ResponseData {
  final String result;
  final String error;

  ResponseData({this.result, this.error});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(result: json['status'], error: json['ERROR']);
  }
}

class LoginData {
  final String token;
  final String error;

  LoginData({this.token, this.error});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(token: json['token'], error: json['ERROR']);
  }
}

class Item {
  String code;
  String name;
  String type;
  Float qty;
  Float price;
  String vId;

  Item({this.code, this.name, this.type, this.qty, this.price, this.vId});
}

class Order {
  final String time;
  final String from;
  final String to;
  final List<Item> items;
  final int total;

  Order({this.time, this.from, this.to, this.items, this.total});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        time: json['Time'],
        from: json['From'],
        to: json['To'],
        items: json['Items'],
        total: json['Total']);
  }
}
