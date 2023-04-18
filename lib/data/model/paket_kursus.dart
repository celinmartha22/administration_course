class PaketKursus {
  late String idPaketKursus;
  late String namaPaketKursus;
  late int harga;
  late String berlakuSelama;
  late String jenjang;
  late String keterangan;

  PaketKursus({
    required this.idPaketKursus,
    required this.namaPaketKursus,
    required this.harga,
    required this.berlakuSelama,
    required this.jenjang,
    required this.keterangan,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPaketKursus': idPaketKursus,
      'namaPaketKursus': namaPaketKursus,
      'harga': harga,
      'berlakuSelama': berlakuSelama,
      'jenjang': jenjang,
      'keterangan': keterangan,
    };
  }

  PaketKursus.fromMap(Map<String, dynamic> map) {
    idPaketKursus = map['idPaketKursus'];
    namaPaketKursus = map['namaPaketKursus'];
    harga = map['harga'];
    berlakuSelama = map['berlakuSelama'];
    jenjang = map['jenjang'];
    keterangan = map['keterangan'];
  }
}
