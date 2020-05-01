import 'dart:ui';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './loginStatus.dart';
import './Classes.dart';
import './Functions.dart';

Future<ResponseData> addItem(
    String cd, String nm, String typ, String qty, String mrp) async {
  final response = await http.post(
    url + '/additem',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': user['token'],
    },
    body: jsonEncode(<String, String>{
      'User': user['uname'],
      'Code': cd,
      'Name': nm,
      'Type': typ,
      'Qty': qty,
      'Price': mrp,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ResponseData.fromJson(data);
  } else {
    throw Exception('Failed to SignUp');
  }
}

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _controller_Cd = TextEditingController();
  final TextEditingController _controller_Nm = TextEditingController();
  final TextEditingController _controller_Qty = TextEditingController();
  final TextEditingController _controller_Mrp = TextEditingController();
  String typValue = "--Select--";

  List<String> typList = [
    '--Select--',
    'Rice',
    'Cereals',
    'Oil',
    'Spices',
    'Flours and Powders',
    'Nuts',
    'Tolilet items',
    'Cleaning aids'
  ];

  Future<ResponseData> _futureData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Item",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.green[100]],
                    stops: [0.9, 1])),
        child: Center(
          child: ListView(shrinkWrap: true, children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Item Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                      maxLength: 70,
                      controller: _controller_Nm,
                      obscureText: false,
                      decoration: InputDecoration(
                          hoverColor: Colors.white,
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                          hintText: "Item Name {Eg: Kera Coconut Oil 500ml Pack}")),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Item Code",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                      controller: _controller_Cd,
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                          hintText: "Item Code {Eg:KRA_CC_OIL_500}")),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Item Type",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("Select"),
                    value: typValue,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.green,
                    ),
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    underline: Container(height: 2, color: Colors.green),
                    onChanged: (String newValue) {
                      setState(() {
                        typValue = newValue;
                      });
                    },
                    items: typList.map((String val) {
                      return DropdownMenuItem<String>(
                        child: Text(
                          '$val',
                          style: TextStyle(fontSize: 16),
                        ),
                        value: val,
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Stock",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                      keyboardType: TextInputType.number,
                      controller: _controller_Qty,
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                          hintText: "Enter currently available stock")),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Price",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                      keyboardType: TextInputType.number,
                      controller: _controller_Mrp,
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                          hintText: "Enter Retail Price per unit/kg")),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 5),
                child: FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () async {
                    print("Button pressed");

                    if (_controller_Nm.text == "" ||
                        _controller_Cd.text == "" ||
                        typValue == '--Select--' ||
                        _controller_Qty.text == "" ||
                        _controller_Mrp.text == "") {
                      showError(context, "Enter all details");
                    } else {
                      _futureData = addItem(
                        _controller_Cd.text,
                        _controller_Nm.text,
                        typValue,
                        _controller_Qty.text,
                        _controller_Mrp.text,
                      );
                    }

                    var _data, _error;
                    _futureData.then((res) {
                      _data = res.result;
                      _error = res.error;
                      print("Data:$_data  Error:$_error");

                      if (_data == 'done') {
                        showMessage(context, "Item Added Successfully");
                        _controller_Cd.clear();
                        _controller_Nm.clear();
                        _controller_Qty.clear();
                        setState(() {
                          typValue = "--Select--";
                        });
                        _controller_Mrp.clear();
                      } else {
                        showError(context, _error);
                        print(_error);
                      }
                    });
                    _futureData = null;
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
