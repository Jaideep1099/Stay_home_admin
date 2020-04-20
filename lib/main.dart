import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './signup.dart';

Future<LoginData> fetchLogin() async {
  final response = await http.post("http://192.168.43.60:10000/vendor/login");

  if (response.statusCode == 200) {
    return LoginData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to Login');
  }
}

class LoginData {
  final String sId;

  LoginData({this.sId});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(sId: json['login']);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var sgn = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Stay Home Admin',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Stay Home Admin"),
            ),
            backgroundColor: Colors.lightGreen,
            body: (sgn == 1)
            ? Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    obscureText:true,
                    decoration:InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder())
                  ),
                ),
            ]) 
            : SignUp()
            ));
  }
}
