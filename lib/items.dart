import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './loginStatus.dart';
import './Classes.dart';
import './Functions.dart';
import './updateitem.dart';

Future<List<Item>> fetchItems() async {
  final response = await http.post(url + '/listitems',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': user['token'],
      },
      body: jsonEncode(<String, String>{'User': user['uname']}));
  if (response.statusCode == 200) {
    return compute(parseItems, response.body);
  } else {
    throw Exception("Failed to fetch items");
  }
}

List<Item> parseItems(String responseBody) {
  var data = jsonDecode(responseBody);
  data = data["Items"];
  final parsed = data.cast<Map<String, dynamic>>();
  List<Item> items= parsed.map<Item>((json) => Item.fromJson(json)).toList();
  items.sort((a,b)=>a.name.compareTo(b.name));
  return items;
}

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Items")),
      body: FutureBuilder<List<Item>>(
        future: fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            print(
              snapshot.error,
            );

          return snapshot.hasData
              ? ItemsList(items: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ItemsList extends StatelessWidget {
  final List<Item> items;

  ItemsList({this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemView(items[index]);
      },
    );
  }
}

class ItemView extends StatelessWidget {
  final Item it;
  ItemView(this.it);
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
                    it.code,
                    style: _style,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Text(it.name,
                        style: TextStyle(
                            color: Colors.green[900],
                            fontSize: 26,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text(it.type, style: _style),
                  Text('Price: ${it.price}', style: _style),
                  Text('Stock: ${it.qty}', style: _style),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return UpdateItem(it);
                        }));
                      },
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
