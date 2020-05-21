import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import './Classes.dart';

showError(BuildContext context, String error) {
  Alert(
    context: context,
    title: '$error',
    buttons: [
      DialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Back",
            style: TextStyle(color: Colors.white),
          ))
    ],
  ).show();
}

showMessage(BuildContext context, String msgTitle) {
  Alert(
      context: context,
      title: '$msgTitle',
      content: Icon(
        Icons.done,
        color: Colors.green,
        size: 40,
      ),
      buttons: []).show();
}

List<Order> parseOrders(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Order>((json) => Order.fromJson(json)).toList();
}
