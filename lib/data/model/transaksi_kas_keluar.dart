class TransaksiKasKeluar {
  late String idTransaksiKasKeluar;
  late String tanggal;
  late String idJenisKasKeluar;
  late String idAsisten;
  late String penerima;
  late int nominal;
  late String keterangan;

  TransaksiKasKeluar({
    required this.idTransaksiKasKeluar,
    required this.tanggal,
    required this.idJenisKasKeluar,
    required this.idAsisten,
    required this.penerima,
    required this.nominal, 
    required this.keterangan,
  });

  Map<String, dynamic> toMap() {
    return {
      'idTransaksiKasKeluar': idTransaksiKasKeluar,
      'tanggal': tanggal,
      'idJenisKasKeluar': idJenisKasKeluar,
      'idAsisten': idAsisten,
      'penerima': penerima,
      'nominal': nominal,
      'keterangan': keterangan,
    };
  }

  TransaksiKasKeluar.fromMap(Map<String, dynamic> map) {
    idTransaksiKasKeluar = map['idTransaksiKasKeluar'];
    tanggal = map['tanggal'];
    idJenisKasKeluar = map['idJenisKasKeluar'];
    idAsisten = map['idAsisten'];
    penerima = map['penerima'];
    nominal = map['nominal'];
    keterangan = map['keterangan'];
  }
}
