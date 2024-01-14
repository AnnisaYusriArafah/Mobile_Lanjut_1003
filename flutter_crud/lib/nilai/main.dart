import 'package:flutter/material.dart';
import 'package:flutter_application_crud/nilai/apinilai.dart';
import 'package:flutter_application_crud/nilai/nilai.dart';

void main() {
  runApp(const NilaiPage());
}

class NilaiPage extends StatelessWidget {
  const NilaiPage({Key? key});

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
  final TextEditingController _idMahasiswaController = TextEditingController();
  final TextEditingController _idMatakuliahController = TextEditingController();
  final TextEditingController _nilaiController = TextEditingController();
  List<Nilai> nilaiList = []; // Updated to store the list of Nilai

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nilai'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _idMahasiswaController,
                    decoration: const InputDecoration(labelText: 'ID Mahasiswa'),
                  ),
                  TextFormField(
                    controller: _idMatakuliahController,
                    decoration: const InputDecoration(labelText: 'ID Matakuliah'),
                  ),
                  TextFormField(
                    controller: _nilaiController,
                    decoration: const InputDecoration(labelText: 'Nilai'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _createNilai();
                    },
                    child: const Text('Create Nilai'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Nilai>>(
              future: _apiService.fetchNilai(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  nilaiList = snapshot.data!; // Update nilaiList from API response
                  return ListView.builder(
                    itemCount: nilaiList.length,
                    itemBuilder: (context, index) {
                      return _buildListTile(nilaiList[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(Nilai nilai) {
    return ListTile(
      title: Text('ID Mahasiswa: ${nilai.idmahasiswa}'),
      subtitle: Text('ID Matakuliah: ${nilai.idmatakuliah}'),
      onTap: () async {
        await _showUpdateDialog(nilai);
      },
      onLongPress: () async {
        await _apiService.deleteNilai(nilai.id);
        _refreshUI();
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _apiService.deleteNilai(nilai.id);
              _refreshUI();
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await _showUpdateDialog(nilai);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _createNilai() async {
    // Validation and error handling
    if (_idMahasiswaController.text.isEmpty ||
        _idMatakuliahController.text.isEmpty ||
        _nilaiController.text.isEmpty) {
      // Handle invalid input
      return;
    }

    Nilai newNilai = Nilai(
      id: 0,
      idmahasiswa: int.parse(_idMahasiswaController.text),
      idmatakuliah: int.parse(_idMatakuliahController.text),
      nilai: double.parse(_nilaiController.text),
    );

    // Call the API service to create Nilai
    Nilai createdNilai = await _apiService.createNilai(newNilai);

    // Clear text fields
    _idMahasiswaController.clear();
    _idMatakuliahController.clear();
    _nilaiController.clear();

    // Update UI with the created Nilai
    setState(() {
      nilaiList.add(createdNilai);
    });
  }

  Future<void> _showUpdateDialog(Nilai nilai) async {
    _idMahasiswaController.text = nilai.idmahasiswa.toString();
    _idMatakuliahController.text = nilai.idmatakuliah.toString();
    _nilaiController.text = nilai.nilai.toString();



    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Nilai'),
          content: Column(
            children: [
              TextFormField(
                controller: _idMahasiswaController,
                decoration: const InputDecoration(labelText: 'ID Mahasiswa'),
              ),
              TextFormField(
                controller: _idMatakuliahController,
                decoration: const InputDecoration(labelText: 'ID Matakuliah'),
              ),
              TextFormField(
                controller: _nilaiController,
                decoration: const InputDecoration(labelText: 'Nilai'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),

          ],
        );
      },
    );
  }

  Future<void> _updateNilai(Nilai nilai) async {
    // Validation and error handling
    if (_idMahasiswaController.text.isEmpty ||
        _idMatakuliahController.text.isEmpty ||
        _nilaiController.text.isEmpty) {
      // Handle invalid input
      return;
    }

    Nilai updatedNilai = Nilai(
      id: nilai.id,
      idmahasiswa: int.parse(_idMahasiswaController.text),
      idmatakuliah: int.parse(_idMatakuliahController.text),
      nilai: double.parse(_nilaiController.text),
    );
    await _apiService.updateNilai(updatedNilai);

    // Clear text fields
    _idMahasiswaController.clear();
    _idMatakuliahController.clear();
    _nilaiController.clear();

    // Update UI with the updated Nilai
    _refreshUI();
  }

  void _refreshUI() {
    setState(() {});
  }
}
