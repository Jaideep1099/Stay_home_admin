import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './home.dart';
import './signin.dart';

var user = {"sId": "v", "uname": ""};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
