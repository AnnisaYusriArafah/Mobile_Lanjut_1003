import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Fitted Box"),
              centerTitle: true,
            ),
            body: Center(
              child: Container(
                color: Colors.blue,
                width: 300,
                height: 110,
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  fit: BoxFit.fill,
                  child: Image.network(
                      "https://picsum.photos/seed/picsum/200/300"),
                ),
              ),
            )));
  }
}
