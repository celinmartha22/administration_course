class Asisten {
  late String idAsisten;
  late String namaAsisten;
  late String jabatan;
  late String alamat;
  late String jenisKelamin;
  late String nomorHP;

  Asisten({
    required this.idAsisten,
    required this.namaAsisten,
    required this.jabatan,
    required this.alamat,
    required this.jenisKelamin,
    required this.nomorHP,
  });

  Map<String, dynamic> toMap() {
    return {
      'idAsisten': idAsisten,
      'namaAsisten': namaAsisten,
      'jabatan': jabatan,
      'alamat': alamat,
      'jenisKelamin': jenisKelamin,
      'nomorHP': nomorHP,
    };
  }

  Asisten.fromMap(Map<String, dynamic> map) {
    idAsisten = map['idAsisten'];
    namaAsisten = map['namaAsisten'];
    jabatan = map['jabatan'];
    alamat = map['alamat'];
    jenisKelamin = map['jenisKelamin'];
    nomorHP = map['nomorHP'];
  }
}
