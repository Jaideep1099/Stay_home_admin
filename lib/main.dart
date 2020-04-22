import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './signin.dart';

var user = {"sId": "v", "uname": "TK25"};

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StayHome Admin',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SignIn(),
    );
  }
}
