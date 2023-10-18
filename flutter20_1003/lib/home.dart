import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = "False";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog"),
      ), // AppBar
      body: Center(
        child: Text(
          data,
          style: TextStyle(
            fontSize: 35,
          ), // TextStyle
        ), // Text
      ), // Center
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Telah diklik");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Konfirmasi"),
              content: Text("Apakah Anda yakin ingin melakukan ini?"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("Ya"),
                  onPressed: () {
                    // Lakukan sesuatu
                  },
                ),
                ElevatedButton(
                  child: Text("False"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.delete),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
