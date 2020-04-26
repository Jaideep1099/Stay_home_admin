import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './Classes.dart';
import './Functions.dart';
import './loginStatus.dart';

Future<OrderStatus> fetchOrderStatus() async {
  final response = await http.post(
    url + '/status',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': user['token'],
    },
  );
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return OrderStatus.fromJson(data);
  } else {
    throw Exception("Unable to fetch order details");
  }
}

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Future<OrderStatus> _futureOrderDetails;
  List<Order> pnd;
  List<Order> cnf;
  List<Order> cmp;
  @override
  void initState() {
    super.initState();
    _futureOrderDetails = fetchOrderStatus();
    _futureOrderDetails.then((data) {
      setState(() {
        pnd = data.pending;
        cnf = data.confirmed;
        cmp = data.completed;
      });
    });
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Orders"),
            bottom: TabBar(tabs: [
              Tab(
                text: "Pending",
                icon: Icon(Icons.access_time),
              ),
              Tab(
                text: "Confirmed",
                icon: Icon(Icons.done),
              ),
              Tab(
                text: "Completed",
                icon: Icon(Icons.done_all),
              )
            ]),
          ),
          body: TabBarView(children: [
            OrderList(orders: pnd),
            OrderList(orders: cnf),
            OrderList(orders: cmp),
          ]),
        ));
  }
}

class OrderList extends StatelessWidget {
  final List<Order> orders;

  OrderList({this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders == null)
      return Icon(Icons.warning);
    else
      return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Text("$index");
          });
  }
}
