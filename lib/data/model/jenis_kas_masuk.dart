class JenisKasMasuk {
  late String idJenisKasMasuk;
  late String jenisPemasukan;

  JenisKasMasuk({
    required this.idJenisKasMasuk,
    required this.jenisPemasukan,
  });

  Map<String, dynamic> toMap() {
    return {
      'idJenisKasMasuk': idJenisKasMasuk,
      'jenisPemasukan': jenisPemasukan,
    };
  }

  JenisKasMasuk.fromMap(Map<String, dynamic> map) {
    idJenisKasMasuk = map['idJenisKasMasuk'];
    jenisPemasukan = map['jenisPemasukan'];
  }
}
