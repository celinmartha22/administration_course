class TransaksiKasMasuk {
  late String idTransaksiKasMasuk;
  late String tanggal;
  late String idJenisKasMasuk;
  late String idSiswa;
  late String pembayar;
  late String idPaketKursus;
  late int nominal;
  late String keterangan;

  TransaksiKasMasuk({
    required this.idTransaksiKasMasuk,
    required this.tanggal,
    required this.idJenisKasMasuk,
    required this.idSiswa,
    required this.pembayar,
    required this.idPaketKursus,
    required this.nominal,
    required this.keterangan,
  });

  Map<String, dynamic> toMap() {
    return {
      'idTransaksiKasMasuk': idTransaksiKasMasuk,
      'tanggal': tanggal,
      'idJenisKasMasuk': idJenisKasMasuk,
      'idSiswa': idSiswa,
      'pembayar': pembayar,
      'idPaketKursus': idPaketKursus,
      'nominal': nominal,
      'keterangan': keterangan,
    };
  }

  TransaksiKasMasuk.fromMap(Map<String, dynamic> map) {
    idTransaksiKasMasuk = map['idTransaksiKasMasuk'];
    tanggal = map['tanggal'];
    idJenisKasMasuk = map['idJenisKasMasuk'];
    idSiswa = map['idSiswa'];
    pembayar = map['pembayar'];
    idPaketKursus = map['idPaketKursus'];
    nominal = map['nominal'];
    keterangan = map['keterangan'];
  }
}
