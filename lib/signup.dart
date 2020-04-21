import 'dart:ui';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './Functions.dart';
import './Classes.dart';

Future<ResponseData> trySignUp(String nm, String uid, String eid, String no,
    String pwd, String loc) async {
  final response = await http.post(
    "http://192.168.43.60:8000/vendor/register",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'vSignUp'
    },
    body: jsonEncode(<String, String>{
      'Name': nm,
      'User': uid,
      'Email': eid,
      'No': no,
      'Password': pwd,
      'Location': loc,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ResponseData.fromJson(data);
  } else {
    throw Exception('Failed to SignUp');
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _controller_nm = TextEditingController();
  final TextEditingController _controller_uid = TextEditingController();
  final TextEditingController _controller_eid = TextEditingController();
  final TextEditingController _controller_no = TextEditingController();
  final TextEditingController _controller_loc = TextEditingController();
  final TextEditingController _controller_pwd = TextEditingController();

  Future<ResponseData> _futureData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUp")),
      body: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(40, 30, 40, 10),
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
                  controller: _controller_nm,
                  obscureText: false,
                  decoration: InputDecoration(
                      hoverColor: Colors.white,
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
                  controller: _controller_uid,
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
                  controller: _controller_eid,
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
                keyboardType: TextInputType.numberWithOptions(decimal:false),
                  controller: _controller_no,
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
                  controller: _controller_loc,
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
                  controller: _controller_pwd,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(),
                      hintText: "Password")),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(40, 30, 40, 5),
            child: FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () async {
                print("Button pressed");
                setState(() {
                  if (_controller_uid.text == "" ||
                      _controller_pwd.text == "" ||
                      _controller_no.text == "" ||
                      _controller_nm.text == "") {
                    showError(context, "Enter all details");
                  } else {
                    _futureData = trySignUp(
                        _controller_nm.text,
                        _controller_uid.text,
                        _controller_eid.text,
                        _controller_no.text,
                        _controller_pwd.text,
                        _controller_loc.text);
                  }
                });
                var data, error;
                _futureData.then((res) {
                  data = res.result;
                  error = res.error;
                  print("Data:$data  Error:$error");
                  if (data == 'done') {
                    Navigator.pop(context);
                    showMessage(context,
                        "Vendor Registered Successfully! Sign In to continue");
                  } else {
                    showError(context, error);
                    print(error);
                  }
                });
              },
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )),
      ]),
    );
  }
}
