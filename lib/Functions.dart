import 'package:flutter/material.dart';

showError(BuildContext context, String error) {
  var alert = AlertDialog(
    title: Text('$error'),
    actions: <Widget>[
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("back"))
    ],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

showMessage(BuildContext context, String msg) {
  var alert = AlertDialog(
    title: Text('$msg'),
    content: Icon(Icons.done, color: Colors.green,),
    );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
