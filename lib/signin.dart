import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './signup.dart';


  void _makePostRequest(String _userName,String _password) async {
    String url = 'http://18.217.223.174:8000/vendor/signin';
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'vSignIn'
      },
      body:
          jsonEncode(<String, String>{'User': _userName, 'Password': _password}),
    );
    int status = response.statusCode;
    Map<String, dynamic> data = json.decode(response.body);
    print(
        "Response status from server: $status message: ${data['login']}"); //insted of login
    //set key of sessionID
  }

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  var _userName = null;
  var _password = null;

  final idCont = TextEditingController();
  final passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stay Home Admin"),
        ),
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('UserID',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(8),
                      child: TextField(
                          controller: idCont,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                            hintText: 'Enter User Name',
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(8),
                      child: TextField(
                          controller: passCont,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                            hintText: 'Enter Password',
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
                  width: double.infinity,
                  height: 60.0,
                  child: FlatButton(
                    padding: EdgeInsets.all(8),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        _userName = idCont.text;
                        _password = passCont.text;
                      });
                      print('Login Button Pressed');
                      _makePostRequest(_userName,_password);
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 1.5,
                      ),
                    ),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUp();
                    }));
                  },
                  child: Text(
                    "New user? SignUp",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans'),
                  ))
            ]));
  }
}
