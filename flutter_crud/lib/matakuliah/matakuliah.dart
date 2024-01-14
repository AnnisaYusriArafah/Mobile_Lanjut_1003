class Matakuliah {
  int id;
  String kode; // Tambahkan atribut kode
  String nama;
  int sks;

  Matakuliah({
    required this.id,
    required this.kode,
    required this.nama,
    required this.sks,
  });

  factory Matakuliah.fromJson(Map<String, dynamic> json) {
    return Matakuliah(
      id: json['id'],
      kode: json['kode'], // Sesuaikan dengan atribut yang ada di API
      nama: json['nama'],
      sks: json['sks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode': kode, // Sesuaikan dengan atribut yang ada di API
      'nama': nama,
      'sks': sks,
    };
  }
}
