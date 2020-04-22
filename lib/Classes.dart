import 'dart:ffi';
import 'package:flutter/material.dart';

class ResponseData {
  final String result;
  final String error;

  ResponseData({this.result, this.error});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      result: json['status'],
      error: json['ERROR']
      );
  }
}

class Item {
  String code;
  String name;
  String type;
  Float qty;
  Float price;
  String vId;

  Item({this.code,this.name,this.type,this.qty,this.price,this.vId});
}

class Order {
  final String time;
  final String from;
  final String to;
  final List<Item> items;
  final int total;

  Order({this.time,this.from,this.to,this.items,this.total});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      time: json['Time'],
      from: json['From'],
      to: json['To'],
      items: json['Items'],
      total: json['Total']
    );
  }
}

class OrderList extends StatelessWidget {
  final List<Order> orders;

  OrderList({this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
    );
  }
}