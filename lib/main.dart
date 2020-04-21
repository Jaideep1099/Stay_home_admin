import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './signup.dart';
import './additem.dart';

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

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stay Home Admin"),
        ),
        //  backgroundColor: Colors.lightGreen,
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder())),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUp();
                    }));
                  },
                  child: Text("New user? SignUp")),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddItem();
                    }));
                  },
                  child: Text("AddItem")),
            ]));
  }
}
