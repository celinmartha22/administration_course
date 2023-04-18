import 'package:administration_course/data/model/overview_kategori.dart';

class Overview {
  late int totalKursus;
  late int totalSiswa;
  late int totalAsisten;
  late int totalSaldoMasuk;
  late int totalSaldoKeluar;
  late List<OverviewKategori> dataKasMasukKategori;
  late List<OverviewKategori> dataKasKeluarKategori;

  Overview({
    required this.totalKursus,
    required this.totalSiswa,
    required this.totalAsisten,
    required this.totalSaldoMasuk,
    required this.totalSaldoKeluar,
    required this.dataKasMasukKategori,
    required this.dataKasKeluarKategori,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalKursus': totalKursus,
      'totalSiswa': totalSiswa,
      'totalAsisten': totalAsisten,
      'totalSaldoMasuk': totalSaldoMasuk,
      'totalSaldoKeluar': totalSaldoKeluar,
      'dataKasMasukKategori': dataKasMasukKategori,
      'dataKasKeluarKategori': dataKasKeluarKategori,
    };
  }

  Overview.fromMap(Map<String, dynamic> map) {
    totalKursus = map['totalKursus'];
    totalSiswa = map['totalSiswa'];
    totalAsisten = map['totalAsisten'];
    totalSaldoMasuk = map['totalSaldoMasuk'];
    totalSaldoKeluar = map['totalSaldoKeluar'];
    dataKasMasukKategori = map['dataKasMasukKategori'];
    dataKasKeluarKategori = map['dataKasKeluarKategori'];
  }
}
