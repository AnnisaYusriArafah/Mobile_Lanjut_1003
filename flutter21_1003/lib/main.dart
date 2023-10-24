import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> items =
      List.generate(20, (index) => "AnnisaYusriArafah ${index + 1}");

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dismissible Example"),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text("Konfirmasi"),
                      content:
                          Text("Apakah Anda yakin ingin menghapus item ini?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Batal"),
                          onPressed: () {
                            Navigator.of(dialogContext).pop(); // Tutup dialog.
                          },
                        ),
                        TextButton(
                          child: Text("Hapus"),
                          onPressed: () {
                            removeItem(index); // Hapus item setelah konfirmasi.
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Item dihapus"),
                              ),
                            );
                            Navigator.of(dialogContext).pop(); // Tutup dialog.
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete, color: Colors.white),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
              ),
              child: ListTile(
                title: Text(item),
              ),
            );
          },
        ),
      ),
    );
  }
}
