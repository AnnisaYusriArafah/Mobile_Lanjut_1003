import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Color> myColor = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber
  ];
  final List<Widget> myList = List.generate(
    100,
    (index) => Text(
      "${index + 1}",
      style: TextStyle(
        fontSize: 20 + double.parse(index.toString()),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("List View"),
          ),
          body: ListView(
            children: myList,
            // separatorBuilder: (context,index){
            //   return Container(
            //     height: 50,
            //     color: Colors.black
            //   );
            // },
            // itemCount: myColor.length, //untuk menghitung jumlah seluruh children dari color
            // itemBuilder: (context, index) {
            //   return Text("Hello Annisa");
            //   },
          )),
    );
  }
}
