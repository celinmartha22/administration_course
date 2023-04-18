class JenisKas {
  late String idJenisKas;
  late String namaJenisKas;
  late String status;
  late int warna;
  late String ikon;

  JenisKas({
    required this.idJenisKas,
    required this.namaJenisKas,
    required this.status,
    required this.warna,
    required this.ikon,
  });

  Map<String, dynamic> toMap() {
    return {
      'idJenisKas': idJenisKas,
      'namaJenisKas': namaJenisKas,
      'status': status,
      'warna': warna,
      'ikon': ikon,
    };
  }

  JenisKas.fromMap(Map<String, dynamic> map) {
    idJenisKas = map['idJenisKas'];
    namaJenisKas = map['namaJenisKas'];
    status = map['status'];
    warna = map['warna'];
    ikon = map['ikon'];
  }
}
