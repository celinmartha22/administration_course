class JenisKasKeluar {
  late String idJenisKasKeluar;
  late String jenisPengeluaran;

  JenisKasKeluar({
    required this.idJenisKasKeluar,
    required this.jenisPengeluaran,
  });

  Map<String, dynamic> toMap() {
    return {
      'idJenisKasKeluar': idJenisKasKeluar,
      'jenisPengeluaran': jenisPengeluaran,
    };
  }

  JenisKasKeluar.fromMap(Map<String, dynamic> map) {
    idJenisKasKeluar = map['idJenisKasKeluar'];
    jenisPengeluaran = map['jenisPengeluaran'];
  }
}
