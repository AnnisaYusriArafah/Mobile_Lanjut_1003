import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text("Aplikasi Annisa"),
        ),
        body: const Center(
          child: Text(
            "Hello Annisa, kamu adalah mahasiswa politeknik negeri padang dan asal solok berumur 19 tahun lalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal",
            maxLines: 3, //membuat baris
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center, //posisi text tengah
            style: TextStyle(
              //memberikan style teks
              backgroundColor: Colors.cyanAccent,
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 10,
              fontFamily: 'Schyler',
              decorationStyle: TextDecorationStyle.wavy,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red,
              decorationThickness: 2,
            ),
          ),
        ),
      ),
    );
  }
}
