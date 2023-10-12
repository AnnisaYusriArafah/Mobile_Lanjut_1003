import 'package:flutter/material.dart';

main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(
          title: Text("Culomn"),
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center, //untuk memposisikan letak relative width
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 50,
              color: Colors.green,
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue,
            ),
            Container(
              width: 100,
              height: 50,
              color: Colors.cyanAccent,
            ),
            Container(
              width: 150,
              height: 50,
              color: Colors.amber,
            ),
          ],
        )
      ),
    );
  }
}
