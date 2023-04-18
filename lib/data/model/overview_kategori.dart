class OverviewKategori {
  late String ikon;
  late int warna;
  late String namaKategori;
  late int total;

  OverviewKategori({
    required this.ikon,
    required this.warna,
    required this.namaKategori,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'ikon': ikon,
      'warna': warna,
      'namaKategori': namaKategori,
      'total': total,
    };
  }

  OverviewKategori.fromMap(Map<String, dynamic> map) {
    ikon = map['ikon'];
    warna = map['warna'];
    namaKategori = map['namaKategori'];
    total = map['total'];
  }
}
