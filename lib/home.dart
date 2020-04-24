import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import './Classes.dart';
import './Functions.dart';
import './signin.dart';
import './additem.dart';
import './updateitem.dart';
import './loginStatus.dart';

Future<List<Order>> fetchOrders() async {
  final response = await http.post(url + '/status',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': user['token'],
      },
      body: jsonEncode(<String, String>{
        'User': user['uname'],
      }));

  return compute(parseOrders, response.body);
}

Future<ResponseData> logout() async {
  final response = await http.post(
    url + '/logout',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': user['token'],
    },
    body: jsonEncode(<String, String>{
      'User': user['uname'],
    }),
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ResponseData.fromJson(data);
  } else {
    throw Exception('Failed to logout');
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<ResponseData> _futureData;

  _saveLogoutStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user['isLoggedIn'] = 0;
      user['token'] = 'v';
      user['uname'] = '';
      prefs.setInt('isLoggedIn', 0);
      prefs.setString('token', 'v');
      prefs.setString('uname', '');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user['isLoggedIn'] == 0)
      return SignIn();
    else
      return Scaffold(
        appBar: AppBar(title: Text("Home")),
        drawer: Drawer(
            child: SafeArea(
              child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: double.infinity,
                  color: Colors.green,
                  child: Text(
                    "Stay Home Vendor",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ))
          ],
        ),
            )),
        body: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: <Widget>[
            HomePageButton(
                text: "Add Item", icon: Icons.add_box, page: AddItem()),
            HomePageButton(
                text: "Update Item Details",
                icon: Icons.update,
                page: UpdateItem()),
            Container(
              padding: EdgeInsets.all(12),
              child: FlatButton(
                onPressed: () async {
                  _futureData = logout();
                  _futureData.then((data) {
                    if (data.result == 'done') {
                      _saveLogoutStatus();
                      setState(() {
                        user['isLoggedIn'] = 0;
                      });
                    } else {
                      showError(context, data.error);
                    }
                  });
                  _futureData = null;
                },
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        size: 50,
                      ),
                      Text("Logout")
                    ]),
                color: Colors.green,
                textColor: Colors.white70,
              ),
            ),
          ],
        ),
      );
  }
}

class HomePageButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final dynamic page;
  HomePageButton({this.text, this.icon, this.page});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return page;
          }));
        },
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50,
              ),
              Text(text)
            ]),
        color: Colors.green,
        textColor: Colors.white70,
      ),
    );
  }
}
