import 'package:flutter/material.dart';
import 'package:flutter_application_crud/mahasiswa.dart';
import 'package:flutter_application_crud/api.dart';

void main() {
  runApp(const mahasiswaApp());
}

class mahasiswaApp extends StatelessWidget {
  const mahasiswaApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService _apiService = ApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _tgllahirController = TextEditingController();

  int idMahasiswa = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CRUD Example'),
        ),
        body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Id data : $idMahasiswa"),
                      TextFormField(
                        controller: _namaController,
                        decoration: InputDecoration(labelText: 'Nama'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _tgllahirController,
                        decoration: InputDecoration(labelText: 'Tgl Lahir'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal lahir tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Mahasiswa newPost = Mahasiswa(
                                  id: 0,
                                  nama: _namaController.text,
                                  email: _emailController.text,
                                  tgllahir: _tgllahirController.text,
                                );
                                await _apiService.createMahasiswa(newPost);

                                _namaController.clear();
                                _emailController.clear();
                                _tgllahirController.clear();

                                setState(() {});
                              }
                            },
                            icon: Icon(Icons.add),
                            tooltip: 'Create Post',
                          ),
                          IconButton(
                            onPressed: () {
                              _namaController.clear();
                              _emailController.clear();
                              _tgllahirController.clear();
                              setState(() {
                                idMahasiswa = 0;
                              });
                            },
                            icon: Icon(Icons.refresh),
                            tooltip: 'Refresh',
                          ),
                          IconButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Mahasiswa editPost = Mahasiswa(
                                  id: idMahasiswa,
                                  nama: _namaController.text,
                                  email: _emailController.text,
                                  tgllahir: _tgllahirController.text,
                                );

                                setState(() {
                                  idMahasiswa = 0;
                                });

                                _namaController.clear();
                                _emailController.clear();
                                _tgllahirController.clear();

                                await _apiService.updateMahasiswa(editPost);

                                setState(() {});
                              }
                            },
                            icon: Icon(Icons.edit),
                            tooltip: 'Edit Post',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Flexible(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: FutureBuilder<List<Mahasiswa>>(
                    future: _apiService.getMahasiswa(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
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
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      try {
                                        await _apiService.deleteMahasiswa(posts[index].id);
                                        setState(() {});
                                      } catch (e) {
                                        print('Error deleting data: $e');
                                      }
                                    },
                                    icon: Icon(Icons.delete),
                                    tooltip: 'Delete',
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      idMahasiswa = posts[index].id;
                                      _namaController.text = posts[index].nama;
                                      _emailController.text = posts[index].email;
                                      _tgllahirController.text = posts[index].tgllahir;

                                      setState(() {
                                        idMahasiswa = posts[index].id;
                                      });
                                    },
                                    icon: Icon(Icons.edit),
                                    tooltip: 'Edit',
                                  ),
                                ],
                              ),
                              onTap: () async {
                                idMahasiswa = posts[index].id;
                                _namaController.text = posts[index].nama;
                                _emailController.text = posts[index].email;
                                _tgllahirController.text = posts[index].tgllahir;

                                setState(() {
                                  idMahasiswa = posts[index].id;
                                });
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
            ),
        );
    }
}
