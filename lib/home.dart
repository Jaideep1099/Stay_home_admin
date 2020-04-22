import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import './additem.dart';
import './Classes.dart';
import './Functions.dart';
import './signin.dart';
import './main.dart';


Future<List<Order>> fetchOrders(Map<String,String> user) async {
  final response = await http.post(
    'http://192.168.43.60:8000/vendor/status',
    headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': user['sId'],
    },
    body: jsonEncode(<String,String>{
      'User':user['uname'],
    })
  );

  return compute(parseOrders,response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Home")),
        drawer: Drawer(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                width: double.infinity,
                // height: 60.0,

                color: Colors.green,
                child: Text(
                  "Stay Home Vendor",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900,color: Colors.white),
                  textAlign: TextAlign.center,
                ))
          ],
        )),
        body: AddItem()
      ),
    );
  }
}
