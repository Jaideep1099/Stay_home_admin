import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './loginStatus.dart';
import './signup.dart';
import './home.dart';
import './Classes.dart';
import './Functions.dart';

Future<LoginData> _makePostRequest(String _userName, String _password) async {
  String url = 'http://192.168.43.61:8000/vendor/login';
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'vSignIn'
    },
    body:
        jsonEncode(<String, String>{'User': _userName, 'Password': _password}),
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return LoginData.fromJson(data);
  } else {
    throw Exception('Failed to SignUp');
  }
}

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  var _userName;
  var _password;

  final idCont = TextEditingController();
  final passCont = TextEditingController();

  Future<LoginData> _futureData;

  _saveLoginStatus(String token,String uname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user['isLoggedIn']=1;
      user['token']=token;
      user['uname']=uname;
      prefs.setInt('isLoggedIn', 1);
      prefs.setString('token', token);
      prefs.setString('uname', uname);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user['isLoggedIn'] == 1)
      return Home();
    else
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
                        if (idCont.text == "" || passCont.text == "") {
                          showError(context, "Enter Username and Password");
                        } else {
                          _userName = idCont.text;
                          _password = passCont.text;
                          print('Login Button Pressed');

                          _futureData = _makePostRequest(_userName, _password);
                          var _error, _data;
                          _futureData.then((res) {
                            _error = res.error;
                            _data = res.token;
                            if (_error != null) {
                              showError(context, _error);
                            } else {
                              _saveLoginStatus(_data,_userName);
                              idCont.clear();
                              passCont.clear();

                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return Home();
                              // }));
                            }
                          });

                          _futureData = null;
                        }
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
