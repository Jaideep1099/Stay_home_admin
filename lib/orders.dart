import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './Classes.dart';
import './Functions.dart';


class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Scaffold(
      appBar: AppBar(title: Text("Orders"),
      bottom: TabBar(tabs: [
        Tab(text: "Pending",icon: Icon(Icons.access_time),),
        Tab(text: "Confirmed",icon: Icon(Icons.done),),
        Tab(text: "Completed",icon: Icon(Icons.done_all),)
      ]),),
    ));
  }
}