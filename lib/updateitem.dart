import 'dart:ui';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './loginStatus.dart';
import './Classes.dart';
import './Functions.dart';

Future<ResponseData> updateItem(
    String cd, String nm, String typ, String qty, String mrp) async {
  final response = await http.post(
    url + '/updateitem',
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

class UpdateItem extends StatefulWidget {
  @override
  _UpdateItemState createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
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
      appBar: AppBar(title: Text("Update Item")),
      body: Container(
        height: double.infinity,
        child: ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 10),
            child: Text(
              "Update Item Details",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 25, 40, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Item Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                    controller: _controller_Nm,
                    obscureText: false,
                    decoration: InputDecoration(
                        hoverColor: Colors.white,
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        hintText: "Item Name")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
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
                        hintText: "Item Code")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
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
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
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
                        hintText: "Enter new stock")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 5),
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
                        hintText: "Enter new Price")),
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
                    if (_controller_Nm.text == "" ||
                        _controller_Cd.text == "" ||
                        typValue == '--Select--' ||
                        _controller_Qty.text == "" ||
                        _controller_Mrp.text == "") {
                      showError(context, "Enter all details");
                    } else {
                      _futureData = updateItem(
                          _controller_Cd.text,
                          _controller_Nm.text,
                          typValue,
                          _controller_Qty.text,
                          _controller_Mrp.text);
                    }
                  });
                  String data, error;
                  _futureData.then((res) {
                    data = res.result;
                    error = res.error;
                    print("Data:$data  Error:$error");
                    if (data == 'done') {
                      showMessage(context, "Item details Updated Successfully");
                      _controller_Cd.clear();
                      _controller_Nm.clear();
                      _controller_Qty.clear();
                      setState(() {
                        typValue = "--Select--";
                      });
                      _controller_Mrp.clear();
                    } else {
                      showError(context, error);
                      print(error);
                    }
                  });
                  _futureData = null;
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
