import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './signin.dart';

var user ={
  "sId": "v5e9ef03f558dcc8110c69b45",
  "uname": "TK25"
};

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