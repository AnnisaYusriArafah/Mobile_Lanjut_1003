import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter_application_crud/nilai/main.dart';
import 'package:flutter_application_crud/matakuliah/mainmatakuliah.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenu(),
      routes: {
        '/mahasiswa': (context) => mahasiswaApp (),
        '/matakuliah': (context) => MatakuliahPage(),
        '/nilai': (context) => NilaiPage(),
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pilih Menu:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mahasiswa');
              },
              child: Text('Mahasiswa'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/matakuliah');
              },
              child: Text('Matakuliah'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/nilai');
              },
              child: Text('Nilai'),
            ),
          ],
        ),
      ),
    );
  }
}
