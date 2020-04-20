import 'dart:ui';

import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp();
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Text(
              "SignUp",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        hintText: "Vendor Name")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "UserID",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        hintText: "UserID will be used to LogIn")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Email ID",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        hintText: "Email ID")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Mobile No",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        hintText: "Mobile No.")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Location",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        hintText: "Location/Shop Name")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Password",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        hintText: "Password")),
              ],
            ),
          ),
        ]);
  }
}
