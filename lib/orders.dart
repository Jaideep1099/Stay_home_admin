import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stay_home_admin/home.dart';

import './Classes.dart';
import './Functions.dart';
import './loginStatus.dart';

Future<OrderStatus> fetchOrders() async {
  final response = await http.post(url + '/status',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': user['token'],
      },
      body: jsonEncode(<String, dynamic>{'User': user['uname']}));

  if (response.statusCode == 200) {
    return compute(parseOrders, response.body);
  } else {
    throw Exception("Unable to fetch order details");
  }
}

OrderStatus parseOrders(String responseBody) {
  var data = jsonDecode(responseBody);
  OrderStatus status=OrderStatus.fromJson(data);
  return status;
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
    _futureOrderDetails = fetchOrders();
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
            FutureBuilder<OrderStatus>(
              future: fetchOrders(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                } else
                  return (snapshot.hasData)
                      ? OrderList(orders: snapshot.data.pending,)
                      : CircularProgressIndicator();
              },
            ),
            Icon(Icons.code),
            Icon(Icons.code),
          ]),
        ));
  }
}

class OrderList extends StatelessWidget {
  final List<Order> orders;

  OrderList({this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderView(orders[index]);
      },
    );
  }
}

class OrderView extends StatelessWidget {
  final Order order;
  OrderView(this.order);
  final _style =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.lightGreen[100],
          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    order.orderId,
                    style: _style,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(order.from,
                        style: TextStyle(
                            color: Colors.green[900],
                            fontSize: 26,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: FlatButton(
                      onPressed: () {},
                      child: Text("Edit"),
                      color: Colors.blue[600],
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}
