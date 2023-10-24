import 'package:flutter/material.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController nobpController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController mtkController = TextEditingController();
  TextEditingController algoController = TextEditingController();
  TextEditingController javaController = TextEditingController();

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.black, width: 2.0),
  );

  final TextStyle buttonTextStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            buildLinedTextField(nobpController, "Nomor BP            "),
            buildLinedTextField(namaController, "Nama                    "),
            buildLinedTextField(mtkController, "Nilai Matematika"),
            buildLinedTextField(algoController, "Nilai Algoritma   "),
            buildLinedTextField(javaController, "Nilai Java             "),
            SizedBox(height: 16),
            // Tombol Submit di tengah
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan kode untuk menyimpan data atau perhitungan di sini
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        nobp: nobpController.text,
                        nama: namaController.text,
                        mtk: mtkController.text,
                        algo: algoController.text,
                        java: javaController.text,
                      ),
                    ),
                  );
                },
                child: Text("Proses", style: buttonTextStyle),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Warna latar belakang biru
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLinedTextField(
      TextEditingController controller, String labelText) {
    return Row(
      children: [
        Text(labelText + " :"),
        SizedBox(width: 10),
        Container(
          width: 150, // Lebar kotak
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: outlineInputBorder,
              isDense: true, // Mengurangi jarak antara teks dan garis
            ),
          ),
        ),
      ],
    );
  }
}
