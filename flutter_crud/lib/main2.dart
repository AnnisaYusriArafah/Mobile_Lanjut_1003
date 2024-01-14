import 'package:flutter/material.dart';
import 'package:flutter_application_crud/mahasiswa.dart';
import 'package:flutter_application_crud/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Example'),
      ),
      body: FutureBuilder<List<Mahasiswa>>(
        future: _apiService.getMahasiswa(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Mahasiswa> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].nama),
                  subtitle: Text(posts[index].email),

                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Example: Creating a new post
          Mahasiswa newPost = Mahasiswa(id: 0, nama: 'Dodi', email: 'dedi@gmail.com', tgllahir: '1979-01-01');
          Mahasiswa createdPost = await _apiService.createMahasiswa(newPost);

          // Refresh the UI after CRUD operations
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
