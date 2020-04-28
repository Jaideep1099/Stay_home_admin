import 'package:flutter/material.dart';
import 'dart:ffi';

var url = 'http://192.168.43.61:8000/vendor';

class ResponseData {
  final String result;
  final String error;

  ResponseData({this.result, this.error});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(result: json['status'], error: json['ERROR']);
  }
}

class LoginData {
  final String name;
  final String user;
  final String email;
  final String no;
  final String token;
  final String error;

  LoginData(
      {this.name, this.user, this.email, this.no, this.token, this.error});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
        name: json['Name'],
        user: json['User'],
        email: json['Email'],
        no: json['No'],
        token: json['token'],
        error: json['ERROR']);
  }
}

class Item {
  String code;
  String name;
  String type;
  double qty;
  double price;
  String vId;

  Item({this.code, this.name, this.type, this.qty, this.price, this.vId});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        code: json['Code'],
        name: json['Name'],
        type: json['Type'],
        qty: json['Qty'].toDouble(),
        price: json['Price'].toDouble(),
        vId: json['vId']);
  }
}

class Order {
  String orderId;
  String time;
  String from;
  String to;
  List<Item> items;
  double total;

  Order({this.time, this.from, this.to, this.items, this.total, this.orderId});

  factory Order.fromJson(Map<String, dynamic> json) {
    var list= json['Items'] as List;
    list.runtimeType;
    List<Item> itemList = list.map((i) => Item.fromJson(i)).toList();
    return Order(
        time: json['Time'],
        from: json['From'],
        to: json['To'],
        items: itemList,
        total: json['Total'].toDouble(),
        orderId: json['OrderId']);
  }
}

class OrderStatus {
  List<Order> pending;
  List<Order> confirmed;
  List<Order> completed;

  OrderStatus({this.pending, this.confirmed, this.completed});

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    var parsed = json['Pending'] as List;
    print(parsed.runtimeType);
    List<Order> pendingList =
        parsed.map((j) => Order.fromJson(j)).toList();

    parsed = json['Confirmed'] as List;
    parsed.runtimeType;
    List<Order> confirmedList =
        parsed.map((j) => Order.fromJson(j)).toList();
    parsed = json['Completed'] as List;
    parsed.runtimeType;
    List<Order> completedList =
        parsed.map((j) => Order.fromJson(j)).toList();
    
    return OrderStatus(
        pending: pendingList,
        confirmed: confirmedList,
        completed: completedList);
  }
}
