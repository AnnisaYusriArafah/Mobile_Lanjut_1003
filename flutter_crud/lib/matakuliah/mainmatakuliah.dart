import 'package:flutter/material.dart';
import 'package:flutter_application_crud/matakuliah/apimatakuliah.dart';
import 'package:flutter_application_crud/matakuliah/matakuliah.dart';

void main() {
  runApp(const MatakuliahPage());
}

class MatakuliahPage  extends StatelessWidget {
  const MatakuliahPage({Key? key});

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
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _sksController = TextEditingController();
  bool isUpdateButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Example'),
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
              controller: _kodeController,
              decoration: const InputDecoration(labelText: 'Kode Matakuliah'),
            ),
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama Matakuliah'),
            ),
            TextFormField(
              controller: _sksController,
              decoration: const InputDecoration(labelText: 'SKS'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Example: Creating a new matakuliah
                Matakuliah newMatakuliah = Matakuliah(
                  id: 0,
                  kode: _kodeController.text,
                  nama: _namaController.text,
                  sks: int.parse(_sksController.text),
                );
                Matakuliah createdMatakuliah = await _apiService.createMatakuliah(newMatakuliah);

                // Clear text fields
                _kodeController.clear();
                _namaController.clear();
                _sksController.clear();

                // Refresh the UI after creating a new matakuliah
                setState(() {});
              },
              child: const Text('Create Matakuliah'),
            ),
          ],
        ),
      ),
    ),
    Expanded(
    child: FutureBuilder<List<Matakuliah>>(
    future: _apiService.fetchMatakuliah(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else {
    List<Matakuliah> matakuliahList = snapshot.data!;
    return ListView.builder(
    itemCount: matakuliahList.length,
    itemBuilder: (context, index) {
    return ListTile(
    title: Text('Kode: ${matakuliahList[index].kode}'),
    subtitle: Text('Nama: ${matakuliahList[index].nama}'),
    onTap: () async {
    // Example: Updating a matakuliah
    _kodeController.text = matakuliahList[index].kode;
    _namaController.text = matakuliahList[index].nama;
    _sksController.text = matakuliahList[index].sks.toString();

    setState(() {
    isUpdateButtonEnabled = true;
    });

    await showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: const Text('Update Matakuliah'),
    content: Column(
    children: [
    TextFormField(
    controller: _kodeController,
    decoration: const InputDecoration(labelText: 'Kode Matakuliah'),
    ),
    TextFormField(
    controller: _namaController,
    decoration: const InputDecoration(labelText: 'Nama Matakuliah'),
    ),
    TextFormField(
    controller: _sksController,
    decoration: const InputDecoration(labelText: 'SKS'),
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
    TextButton(
    onPressed: isUpdateButtonEnabled
    ? () async {
    // Example: Updating a matakuliah
    Matakuliah updatedMatakuliah = Matakuliah(
    id: matakuliahList[index].id,
    kode: _kodeController.text,
    nama: _namaController.text,
    sks: int.parse(_sksController.text),
    );
    await _apiService.updateMatakuliah(updatedMatakuliah);

    // Clear text fields
    _kodeController.clear();
    _namaController.clear();
    _sksController.clear();

    // Close the dialog
    Navigator.of(context).pop();

    // Refresh the UI after CRUD operations
    setState(() {});
    }
        : null,
    child: const Text('Update'),
    ),
    ],
    );
    },
    );
    },
    onLongPress: () async {
    // Example: Deleting a matakuliah
    await _apiService.deleteMatakuliah(matakuliahList[index].id);

    // Refresh the UI after CRUD operations
    setState(() {});
    },
    trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
    // Example: Deleting a matakuliah
    await _apiService.deleteMatakuliah(matakuliahList[index].id);

    // Refresh the UI after CRUD operations
    setState(() {});
    },
    ),
    IconButton(
    icon: const Icon(Icons.edit),
    onPressed: () async {
    // Example: Editing a matakuliah
    _kodeController.text = matakuliahList[index].kode;
    _namaController.text = matakuliahList[index].nama;
    _sksController.text = matakuliahList[index].sks.toString();

    setState(() {
    isUpdateButtonEnabled = true;
    });

    await showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: const Text('Edit Matakuliah'),
    content: Column(
    children: [
    TextFormField(
    controller: _kodeController,
    decoration: const InputDecoration(labelText: 'Kode Matakuliah'),
    ),
    TextFormField(
    controller: _namaController,
    decoration: const InputDecoration(labelText: 'Nama Matakuliah'),
    ),
    TextFormField(
    controller: _sksController,
    decoration: const InputDecoration(labelText: 'SKS'),
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
    TextButton(
    onPressed: isUpdateButtonEnabled
    ? () async {
    // Example: Updating a matakuliah
    Matakuliah updatedMatakuliah = Matakuliah(
      id: matakuliahList[index].id,
      kode: _kodeController.text,
      nama: _namaController.text,
      sks: int.parse(_sksController.text),
    );
    await _apiService.updateMatakuliah(updatedMatakuliah);

    // Clear text fields
    _kodeController.clear();
    _namaController.clear();
    _sksController.clear();

    // Close the dialog
    Navigator.of(context).pop();

    // Refresh the UI after CRUD operations
    setState(() {});
    }
        : null,
      child: const Text('Update'),
    ),
    ],
    );
    },
    );
    },
    ),
    ],
    ),
    );
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
}
