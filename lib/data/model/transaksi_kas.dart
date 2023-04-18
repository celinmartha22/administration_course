class TransaksiKas {
  late String idTransaksiKas;
  late String tanggal;
  late int kasMasuk;
  late int kasKeluar;
  late String idDetailKas;
  late String idJenisKas;
  late String keterangan;

  TransaksiKas({
    required this.idTransaksiKas,
    required this.tanggal,
    required this.kasMasuk,
    required this.kasKeluar,
    required this.idDetailKas,
    required this.idJenisKas,
    required this.keterangan,
  });

  Map<String, dynamic> toMap() {
    return {
      'idTransaksiKas': idTransaksiKas,
      'tanggal': tanggal,
      'kasMasuk': kasMasuk,
      'kasKeluar': kasKeluar,
      'idDetailKas': idDetailKas,
      'idJenisKas': idJenisKas,
      'keterangan': keterangan,
    };
  }

  TransaksiKas.fromMap(Map<String, dynamic> map) {
    idTransaksiKas = map['idTransaksiKas'];
    tanggal = map['tanggal'];
    kasMasuk = map['kasMasuk'];
    kasKeluar = map['kasKeluar'];
    idDetailKas = map['idDetailKas'];
    idJenisKas = map['idJenisKas'];
    keterangan = map['keterangan'];
  }
}
