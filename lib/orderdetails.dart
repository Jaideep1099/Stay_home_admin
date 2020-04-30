import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './loginStatus.dart';
import './Classes.dart';
import './Functions.dart';

Future<ResponseData> confirmOrder(Order _order) async {
  final response = await http.post(url + '/confirmorder',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': user['token']
      },
      body: jsonEncode(
          <String, dynamic>{'User': user['uname'], 'OrderID': _order.orderId}));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ResponseData.fromJson(data);
  } else {
    throw Exception('Failed to SignUp');
  }
}

class OrderDetails extends StatefulWidget {
  final int _edit;
  final Order _order;
  OrderDetails(this._order, this._edit);
  @override
  _OrderDetailsState createState() => _OrderDetailsState(_order, _edit);
}

class _OrderDetailsState extends State<OrderDetails> {
  final Order _order;
  final int _edit;
  _OrderDetailsState(this._order, this._edit);

  var _style1 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[900]);
  var _style2 = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, backgroundColor: Colors.white);
  Future<ResponseData> futureData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      backgroundColor: Colors.lightGreen[100],
      body: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.125,
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Text(
                      "OrderID: ",
                      style: _style1,
                    ),
                    Text(
                      _order.orderId,
                      style: _style2,
                    )
                  ]),
                  Row(children: <Widget>[
                    Text(
                      "Time: ",
                      style: _style1,
                    ),
                    Text(
                      _order.time,
                      style: _style2,
                    )
                  ]),
                  Row(children: <Widget>[
                    Text(
                      "No. of Items: ",
                      style: _style1,
                    ),
                    Text(
                      "${_order.items.length}",
                      style: _style2,
                    )
                  ]),
                  Row(children: <Widget>[
                    Text(
                      "Bill Amount: ",
                      style: _style1,
                    ),
                    Text(
                      "${_order.total}",
                      style: _style2,
                    )
                  ]),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.65,
                child: _ItemsView(_order.items)),
            Center(
                child: FlatButton(
                    color: Colors.blue[600],
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_edit == 0) {
                        Navigator.pop(context);
                      } else {
                        futureData = confirmOrder(_order);
                        var _data, _error;
                        futureData.then((res) {
                          _data = res.result;
                          _error = res.error;
                          print("$_data   $_error");
                          if (_data == 'done') {
                            Navigator.pop(context);
                            showMessage(context, "Order Confirmed");
                          } else if (_error != null) {
                            showError(context, _error);
                          }
                        });
                      }
                    },
                    child: Text((_edit == 1) ? "Proceed" : "Back")))
          ],
        ),
      ),
    );
  }
}

class _ItemsView extends StatelessWidget {
  final List<Item> _items;
  _ItemsView(this._items);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //  controller: ScrollController(initialScrollOffset: 0),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return _ItemsViewOne(_items[index]);
        });
  }
}

class _ItemsViewOne extends StatelessWidget {
  final Item _item;
  _ItemsViewOne(this._item);

  var _style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue[100],
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _item.code,
                      style: _style,
                    ),
                    Text(_item.name, style: _style)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: Text("${_item.qty}", style: _style),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: Text("${_item.price}", style: _style),
              ),
            ],
          ),
          SizedBox(height: 5)
        ],
      ),
    );
  }
}
