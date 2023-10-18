import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Container(
            color: Colors.amber,
          ),
          leadingWidth: 50,
          title: Container(
            height: 35,
            color: Colors.red,
          ),
          centerTitle: false,
          actions: [
            Container(
              width: 50,
              color: Colors.purple,
            ),
            Container(
              width: 50,
              color: Colors.black,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: Container(width: 50, height: 200, color: Colors.black),
          ),
          flexibleSpace: Container(
            width: 50,
            height: 200,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
