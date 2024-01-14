import 'dart:convert';

import 'package:flutter_application_crud/matakuliah/matakuliah.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.123.125:9002/api/v1/matakuliah';

  Future<List<Matakuliah>> fetchMatakuliah() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable<dynamic> data = json.decode(response.body);
      return data.map((json) => Matakuliah.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load matakuliah');
    }
  }

  Future<Matakuliah> createMatakuliah(Matakuliah matakuliah) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(matakuliah.toJson()),
    );

    if (response.statusCode == 200) {
      return Matakuliah(
        id: 0,
        kode: matakuliah.kode,
        nama: matakuliah.nama,
        sks: matakuliah.sks,
      );
    } else {
      throw Exception('Failed to create matakuliah');
    }
  }

  Future<Matakuliah> updateMatakuliah(Matakuliah matakuliah) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${matakuliah.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(matakuliah.toJson()),
    );

    if (response.statusCode == 200) {
      return Matakuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update matakuliah');
    }
  }

  Future<void> deleteMatakuliah(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete matakuliah');
    }
  }
}
