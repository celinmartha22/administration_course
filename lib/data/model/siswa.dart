class Siswa {
  late String idSiswa;
  late String namaSiswa;
  late String kelas;
  late String asalSekolah;
  late String jenisKelamin;
  late String tanggalLahir;
  late String tanggalMasuk;
  late String email;
  late String namaAyah;
  late String namaIbu;
  late String nomorHP;
  late String alamat;

  Siswa({
    required this.idSiswa,
    required this.namaSiswa,
    required this.kelas,
    required this.asalSekolah,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.tanggalMasuk,
    required this.email,
    required this.namaAyah,
    required this.namaIbu,
    required this.nomorHP,
    required this.alamat,
  });

  Map<String, dynamic> toMap() => {
        'idSiswa': idSiswa,
        'namaSiswa': namaSiswa,
        'kelas': kelas,
        'asalSekolah': asalSekolah,
        'jenisKelamin': jenisKelamin,
        'tanggalLahir': tanggalLahir,
        'tanggalMasuk': tanggalMasuk,
        'email': email,
        'namaAyah': namaAyah,
        'namaIbu': namaIbu,
        'nomorHP': nomorHP,
        'alamat': alamat,
      };

  Siswa.fromMap(Map<String, dynamic> map) {
    idSiswa = map['idSiswa'];
    namaSiswa = map['namaSiswa'];
    kelas = map['kelas'];
    asalSekolah = map['asalSekolah'];
    jenisKelamin = map['jenisKelamin'];
    tanggalLahir = map['tanggalLahir'];
    tanggalMasuk = map['tanggalMasuk'];
    email = map['email'];
    namaAyah = map['namaAyah'];
    namaIbu = map['namaIbu'];
    nomorHP = map['nomorHP'];
    alamat = map['alamat'];
  }
}
