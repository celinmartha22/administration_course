import 'package:administration_course/data/model/asisten.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/data/model/overview.dart';
import 'package:administration_course/data/model/overview_kategori.dart';
import 'package:administration_course/data/model/paket_kursus.dart';
import 'package:administration_course/data/model/siswa.dart';
import 'package:administration_course/data/model/transaksi_kas.dart';
import 'package:administration_course/data/model/transaksi_kas_keluar.dart';
import 'package:administration_course/data/model/transaksi_kas_masuk.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/pages/asisten/asisten_detail_page.dart';
import 'package:administration_course/pages/home/home_page.dart';
import 'package:administration_course/pages/jenis_kas/jenis_kas_detail_page.dart';
import 'package:administration_course/pages/paket_kursus/paket_kursus_detail_page.dart';
import 'package:administration_course/pages/profile/components/body.dart';
import 'package:administration_course/pages/siswa/siswa_detail_page.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_detail_page.dart';
import 'package:administration_course/pages/transaksi_masuk/transaksi_masuk_detail_page.dart';
import 'package:administration_course/widgets/menu_bar/drawer_header_top.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  // static const String 'user' = 'User';

  /// Inisialisasi Database
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'admin_bimbel_db.dab'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE user (idUser TEXT NOT NULL, username TEXT, password TEXT, name TEXT, email TEXT, loginStatus INT)',
        );
        await db.execute(
          'CREATE TABLE paket_kursus (idPaketKursus TEXT NOT NULL, namaPaketKursus TEXT, harga INT, berlakuSelama TEXT, jenjang TEXT, keterangan TEXT)',
        );
        await db.execute(
          'CREATE TABLE siswa (idSiswa TEXT NOT NULL, namaSiswa TEXT, kelas TEXT, asalSekolah TEXT, jenisKelamin TEXT, tanggalLahir TEXT, tanggalMasuk TEXT, email TEXT, namaAyah TEXT, namaIbu TEXT, nomorHP TEXT, alamat TEXT)',
        );
        await db.execute(
          'CREATE TABLE asisten (idAsisten TEXT NOT NULL, namaAsisten TEXT, jabatan TEXT, alamat TEXT, jenisKelamin TEXT, nomorHP TEXT)',
        );
        await db.execute(
          'CREATE TABLE jenis_kas (idJenisKas TEXT NOT NULL, namaJenisKas TEXT, status TEXT, warna INT, ikon TEXT)',
        );
        await db.execute(
          'CREATE TABLE transaksi_kas_masuk (idTransaksiKasMasuk TEXT NOT NULL, tanggal TEXT,  idJenisKasMasuk TEXT, idSiswa TEXT, pembayar TEXT, idPaketKursus TEXT, nominal INT, keterangan TEXT)',
        );
        await db.execute(
          'CREATE TABLE transaksi_kas_keluar (idTransaksiKasKeluar TEXT NOT NULL, tanggal TEXT, idJenisKasKeluar TEXT, idAsisten TEXT, penerima TEXT, nominal INT,  keterangan TEXT)',
        );
        await db.execute(
          'CREATE TABLE transaksi_kas (idTransaksiKas TEXT NOT NULL, tanggal TEXT, kasMasuk INT, kasKeluar INT, idDetailKas TEXT,idJenisKas TEXT, keterangan TEXT)',
        );
      },
      version: 1,
    );
    return db;
  }

// =============================================================================================================
  Future<Overview> getOverview() async {
    final Database db = await database;
    int totalKursus = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM paket_kursus'))!;
    int totalSiswa =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM siswa'))!;
    int totalAsisten = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM asisten'))!;
    int totalSaldoMasuk = Sqflite.firstIntValue(await db
        .rawQuery('SELECT IFNULL(SUM(nominal),0) FROM transaksi_kas_masuk'))!;
    int totalSaldoKeluar = Sqflite.firstIntValue(await db
        .rawQuery('SELECT IFNULL(SUM(nominal),0) FROM transaksi_kas_keluar'))!;
    List<Map<String, dynamic>> resultsIncome = await db.rawQuery(
        'SELECT jenis_kas.ikon, jenis_kas.warna, jenis_kas.namaJenisKas as namaKategori, SUM(transaksi_kas.kasMasuk) as total FROM transaksi_kas INNER JOIN jenis_kas ON transaksi_kas.idJenisKas = jenis_kas.idJenisKas GROUP BY jenis_kas.idJenisKas');
    List<Map<String, dynamic>> resultsExpense = await db.rawQuery(
        'SELECT jenis_kas.ikon, jenis_kas.warna, jenis_kas.namaJenisKas as namaKategori, SUM(transaksi_kas.kasKeluar) as total FROM transaksi_kas INNER JOIN jenis_kas ON transaksi_kas.idJenisKas = jenis_kas.idJenisKas GROUP BY jenis_kas.idJenisKas');

    final List<OverviewKategori> totalIncomePerKategori;
    totalIncomePerKategori =
        resultsIncome.map((res) => OverviewKategori.fromMap(res)).toList();

    final List<OverviewKategori> totalExpensePerKategori;
    totalExpensePerKategori =
        resultsExpense.map((res) => OverviewKategori.fromMap(res)).toList();

    Overview overview = Overview(
        totalKursus: totalKursus,
        totalSiswa: totalSiswa,
        totalAsisten: totalAsisten,
        totalSaldoMasuk: totalSaldoMasuk,
        totalSaldoKeluar: totalSaldoKeluar,
        dataKasMasukKategori: totalIncomePerKategori,
        dataKasKeluarKategori: totalExpensePerKategori);
    BuildOverview.overviewNotifier.value = overview;
    return overview;
  }

// =============================================================================================================
  Future<void> insertUser(User user) async {
    final Database db = await database;
    await db.insert('user', user.toMap());
    debugPrint("User - Added");
  }

  Future<List<User>> getUser() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query('user');
    debugPrint("User - Get All");
    return results.map((res) => User.fromMap(res)).toList();
  }

  Future<User> getUserById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'user',
      where: 'idUser = ?',
      whereArgs: [id],
    );
    debugPrint("User - Get By Id $id");
    if (results.isEmpty) {
      return User(
          idUser: '-',
          username: '',
          password: '',
          name: '',
          email: '',
          loginStatus: 0);
    } else {
      return results.map((res) => User.fromMap(res)).first;
    }
  }

  Future<User> getUserByUserPass(String user, String pass) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT * FROM user where (username="$user" or email="$user") and password="$pass"');
    debugPrint("User - Get By User $user and Password $pass");
    if (results.isEmpty) {
      return User(
          idUser: '-',
          username: '',
          password: '',
          name: '',
          email: '',
          loginStatus: 0);
    } else {
      return results.map((res) => User.fromMap(res)).first;
    }
  }

  Future<User> getActiveUser() async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.rawQuery('SELECT * FROM user where loginStatus=1');
    debugPrint("User - Get By Status 1");
    if (results.isEmpty) {
      return User(
          idUser: '',
          username: '',
          password: '',
          name: '',
          email: '',
          loginStatus: 0);
    } else {
      return results.map((res) => User.fromMap(res)).first;
    }
  }

  Future<void> updateUserBio(User user) async {
    final Database db = await database;
    await db.update(
      'user',
      user.toMap(),
      where: 'idUser = ?',
      whereArgs: [user.idUser],
    );
    debugPrint("User - ${user.name} Updated");
    DrawerHeaderTop.userNotifier.value = user;
    Body.userNotifier.value = user;
  }

  Future<void> updateUserStatus(String id, int status) async {
    final Database db = await database;
    await db
        .rawQuery("UPDATE user SET loginStatus = $status WHERE idUser = '$id'");
    debugPrint("User - $id Updated status to $status");
  }

  Future<void> deleteUser(String id) async {
    final Database db = await database;
    await db.delete(
      'user',
      where: 'idUser = ?',
      whereArgs: [id],
    );
    debugPrint("User - Id $id Removed");
  }

// =============================================================================================================
  Future<void> insertPaketKursus(PaketKursus paketKursus) async {
    final Database db = await database;
    await db.insert('paket_kursus', paketKursus.toMap());
    debugPrint("Paket Kursus - Added");
    getOverview();
  }

  Future<List<PaketKursus>> getPaketKursus() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query('paket_kursus');
    debugPrint("Paket Kursus - Get All");
    return results.map((res) => PaketKursus.fromMap(res)).toList();
  }

  Future<PaketKursus> getPaketKursusById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'paket_kursus',
      where: 'idPaketKursus = ?',
      whereArgs: [id],
    );
    debugPrint("Paket Kursus - Get By Id $id");

    if (results.isEmpty) {
      return PaketKursus(
          idPaketKursus: '-',
          namaPaketKursus: '',
          harga: 0,
          berlakuSelama: '',
          jenjang: '',
          keterangan: '');
    } else {
      return results.map((res) => PaketKursus.fromMap(res)).first;
    }
  }

  Future<void> updatePaketKursus(PaketKursus paketKursus) async {
    final Database db = await database;
    await db.update(
      'paket_kursus',
      paketKursus.toMap(),
      where: 'idPaketKursus = ?',
      whereArgs: [paketKursus.idPaketKursus],
    );
    debugPrint("Paket Kursus - ${paketKursus.namaPaketKursus} Updated");
    PaketKursusDetailPage.kursusNotifier.value = paketKursus;
  }

  Future<void> deletePaketKursus(String id) async {
    final Database db = await database;
    await db.delete(
      'paket_kursus',
      where: 'idPaketKursus = ?',
      whereArgs: [id],
    );
    debugPrint("Paket Kursus - Id $id Removed");
    getOverview();
  }

// =============================================================================================================
  Future<void> insertSiswa(Siswa siswa) async {
    final Database db = await database;
    await db.insert('siswa', siswa.toMap());
    debugPrint("Siswa - Added");
    getOverview();
  }

  Future<List<Siswa>> getSiswa() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query('siswa');
    debugPrint("Siswa - Get All");
    return results.map((res) => Siswa.fromMap(res)).toList();
  }

  Future<Siswa> getSiswaById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'siswa',
      where: 'idSiswa = ?',
      whereArgs: [id],
    );
    debugPrint("Siswa - Get By Id $id");
    if (results.isEmpty) {
      return Siswa(
          idSiswa: '-',
          namaSiswa: '',
          kelas: '',
          asalSekolah: '',
          jenisKelamin: '',
          tanggalLahir: '',
          tanggalMasuk: '',
          email: '',
          namaAyah: '',
          namaIbu: '',
          nomorHP: '',
          alamat: '');
    } else {
      return results.map((res) => Siswa.fromMap(res)).first;
    }
  }

  Future<void> updateSiswa(Siswa siswa) async {
    final Database db = await database;
    await db.update(
      'siswa',
      siswa.toMap(),
      where: 'idSiswa = ?',
      whereArgs: [siswa.idSiswa],
    );
    debugPrint("Siswa - ${siswa.namaSiswa} Updated");

    SiswaDetailPage.siswaNotifier.value = siswa;
  }

  Future<void> deleteSiswa(String id) async {
    final Database db = await database;
    await db.delete(
      'siswa',
      where: 'idSiswa = ?',
      whereArgs: [id],
    );
    debugPrint("Siswa - Id $id Removed");
    getOverview();
  }

  // =============================================================================================================
  Future<void> insertAsisten(Asisten asisten) async {
    final Database db = await database;
    await db.insert('asisten', asisten.toMap());
    debugPrint("Asisten - Added");
    getOverview();
  }

  Future<List<Asisten>> getAsisten() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query('asisten');
    debugPrint("Asisten - Get All");
    return results.map((res) => Asisten.fromMap(res)).toList();
  }

  Future<Asisten> getAsistenById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'asisten',
      where: 'idAsisten = ?',
      whereArgs: [id],
    );
    debugPrint("Asisten - Get By Id $id");
    if (results.isEmpty) {
      return Asisten(
          idAsisten: '-',
          namaAsisten: '',
          jabatan: '',
          alamat: '',
          jenisKelamin: '',
          nomorHP: '');
    } else {
      return results.map((res) => Asisten.fromMap(res)).first;
    }
  }

  Future<void> updateAsisten(Asisten asisten) async {
    final Database db = await database;
    await db.update(
      'asisten',
      asisten.toMap(),
      where: 'idAsisten = ?',
      whereArgs: [asisten.idAsisten],
    );
    debugPrint("Asisten - ${asisten.namaAsisten} Updated");
    AsistenDetailPage.asistenNotifier.value = asisten;
  }

  Future<void> deleteAsisten(String id) async {
    final Database db = await database;
    await db.delete(
      'asisten',
      where: 'idAsisten = ?',
      whereArgs: [id],
    );
    debugPrint("Asisten - Id $id Removed");
    getOverview();
  }

  // =============================================================================================================

  Future<void> insertJenisKas(JenisKas jenisKas) async {
    final Database db = await database;
    await db.insert('jenis_kas', jenisKas.toMap());
    debugPrint("Jenis Kas - Added");
    getOverview();
  }

  Future<List<JenisKas>> getJenisKas() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query('jenis_kas');
    debugPrint("Jenis Kas - Get All");
    return results.map((res) => JenisKas.fromMap(res)).toList();
  }

  Future<JenisKas> getJenisKasById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'jenis_kas',
      where: 'idJenisKas = ?',
      whereArgs: [id],
    );
    debugPrint("Jenis Kas - Get By Id $id");
    if (results.isEmpty) {
      return JenisKas(
          idJenisKas: '-', namaJenisKas: '', status: '', warna: 0, ikon: '');
    } else {
      return results.map((res) => JenisKas.fromMap(res)).first;
    }
  }

  Future<void> updateJenisKas(JenisKas jenisKas) async {
    final Database db = await database;
    await db.update(
      'jenis_kas',
      jenisKas.toMap(),
      where: 'idJenisKas = ?',
      whereArgs: [jenisKas.idJenisKas],
    );
    debugPrint("Jenis Kas - ${jenisKas.namaJenisKas} Updated");
    JenisKasDetailPage.kategoriNotifier.value = jenisKas;
  }

  Future<void> deleteJenisKas(String id) async {
    final Database db = await database;
    await db.delete(
      'jenis_kas',
      where: 'idJenisKas = ?',
      whereArgs: [id],
    );
    debugPrint("Jenis Kas - Id $id Removed");
    getOverview();
  }

  // =============================================================================================================
  Future<void> insertTransaksiKasMasuk(
      TransaksiKasMasuk transaksiKasMasuk) async {
    final Database db = await database;
    String idMain = "BK${transaksiKasMasuk.idTransaksiKasMasuk.substring(2)}";
    final dataTrans = TransaksiKas(
        idTransaksiKas: idMain,
        tanggal: transaksiKasMasuk.tanggal,
        kasMasuk: transaksiKasMasuk.nominal,
        kasKeluar: 0,
        idDetailKas: transaksiKasMasuk.idTransaksiKasMasuk,
        idJenisKas: transaksiKasMasuk.idJenisKasMasuk,
        keterangan: transaksiKasMasuk.keterangan);
    await db.insert('transaksi_kas_masuk', transaksiKasMasuk.toMap());
    await db.insert('transaksi_kas', dataTrans.toMap());
    debugPrint("TransKasMasuk - Added");
    getOverview();
  }

  Future<List<TransaksiKasMasuk>> getTransaksiKasMasuk() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query('transaksi_kas_masuk');
    debugPrint("TransKasMasuk - Get All");
    return results.map((res) => TransaksiKasMasuk.fromMap(res)).toList();
  }

  Future<TransaksiKasMasuk> getTransaksiKasMasukById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'transaksi_kas_masuk',
      where: 'idTransaksiKasMasuk = ?',
      whereArgs: [id],
    );
    debugPrint("TransKasMasuk - Get By Id $id");
    // return results.map((res) => TransaksiKasMasuk.fromMap(res)).first;
    if (results.isEmpty) {
      return TransaksiKasMasuk(
          idTransaksiKasMasuk: '-',
          tanggal: '',
          idJenisKasMasuk: '',
          idSiswa: '',
          pembayar: '',
          idPaketKursus: '',
          nominal: 0,
          keterangan: '');
    } else {
      return results.map((res) => TransaksiKasMasuk.fromMap(res)).first;
    }
  }

  Future<String> getTotalKasMasuk() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db
        .rawQuery('SELECT SUM(nominal) as TotalAll FROM transaksi_kas_masuk;');
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['TotalAll'].toString();
    }
  }

  Future<String> getTotalKasMasukToday(String tanggal) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(nominal) as Total FROM transaksi_kas_masuk where tanggal like '%$tanggal%';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<String> getTotalKasMasukWeekly(String tanggal) async {
    final DateTime dateTo = DateTime.parse(tanggal);
    final DateTime dateFrom =
        DateTime(dateTo.year, dateTo.month, dateTo.day + 6);
    final String to = DateFormat('yyyy-MM-dd').format(dateTo);
    final String from = DateFormat('yyyy-MM-dd').format(dateFrom);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(nominal) as Total FROM transaksi_kas_masuk where tanggal >= '$dateFrom' and tanggal <= '$dateTo';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<String> getTotalKasMasukMonthly(String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy-MM').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(nominal) as Total FROM transaksi_kas_masuk where tanggal like '%$inDate%';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<String> getTotalKasMasukYearly(String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(nominal) as Total FROM transaksi_kas_masuk where tanggal like '%$inDate%';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<List<TransaksiKasMasuk>> getTransaksiMasukToday(String tanggal) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM transaksi_kas_masuk WHERE tanggal like '%$tanggal%';");
    debugPrint("TransKasMasuk - Hari ini $tanggal");
    return results.map((res) => TransaksiKasMasuk.fromMap(res)).toList();
  }

  Future<List<TransaksiKasMasuk>> getTransaksiMasukWeekly(
      String tanggal) async {
    final DateTime dateTo = DateTime.parse(tanggal);
    final DateTime dateFrom =
        DateTime(dateTo.year, dateTo.month, dateTo.day + 6);
    final String to = DateFormat('yyyy-MM-dd').format(dateTo);
    final String from = DateFormat('yyyy-MM-dd').format(dateFrom);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'transaksi_kas_masuk',
      where: 'tanggal >= ? and tanggal <= ?',
      whereArgs: [dateFrom, dateTo],
    );
    debugPrint("TransKasMasuk - Minggu ini $from - $to");
    return results.map((res) => TransaksiKasMasuk.fromMap(res)).toList();
  }

  Future<List<TransaksiKasMasuk>> getTransaksiMasukMonthly(
      String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy-MM').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM transaksi_kas_masuk WHERE tanggal like '%$inDate%';");
    debugPrint("TransKasMasuk - Bulan ini $inDate");
    return results.map((res) => TransaksiKasMasuk.fromMap(res)).toList();
  }

  Future<List<TransaksiKasMasuk>> getTransaksiMasukYearly(
      String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM transaksi_kas_masuk WHERE tanggal like '%$inDate%';");
    debugPrint("TransKasMasuk - Tahun ini $inDate");
    return results.map((res) => TransaksiKasMasuk.fromMap(res)).toList();
  }

  Future<void> updateTransaksiKasMasuk(
      TransaksiKasMasuk transaksiKasMasuk) async {
    final Database db = await database;
    final dataTransBefore =
        await getTransaksiKasByDetailId(transaksiKasMasuk.idTransaksiKasMasuk);
    final dataTransAfter = TransaksiKas(
        idTransaksiKas: dataTransBefore.idTransaksiKas,
        tanggal: transaksiKasMasuk.tanggal,
        kasMasuk: transaksiKasMasuk.nominal,
        kasKeluar: 0,
        idDetailKas: transaksiKasMasuk.idTransaksiKasMasuk,
        idJenisKas: transaksiKasMasuk.idJenisKasMasuk,
        keterangan: transaksiKasMasuk.keterangan);
    await db.update(
      'transaksi_kas_masuk',
      transaksiKasMasuk.toMap(),
      where: 'idTransaksiKasMasuk = ?',
      whereArgs: [transaksiKasMasuk.idTransaksiKasMasuk],
    );
    await db.update(
      'transaksi_kas',
      dataTransAfter.toMap(),
      where: 'idDetailKas = ?',
      whereArgs: [transaksiKasMasuk.idTransaksiKasMasuk],
    );
    debugPrint(
        "TransKasMasuk - ${transaksiKasMasuk.idTransaksiKasMasuk} Updated");
    TransaksiMasukDetailPage.transaksiNotifier.value = transaksiKasMasuk;
    getOverview();
  }

  Future<void> deleteTransaksiKasMasuk(String id) async {
    final Database db = await database;
    await db.delete(
      'transaksi_kas_masuk',
      where: 'idTransaksiKasMasuk = ?',
      whereArgs: [id],
    );
    await db.delete(
      'transaksi_kas',
      where: 'idDetailKas = ?',
      whereArgs: [id],
    );
    debugPrint("TransKasMasuk - Id $id Removed");
    getOverview();
  }

  // =============================================================================================================

  Future<void> insertTransaksiKasKeluar(
      TransaksiKasKeluar transaksiKasKeluar) async {
    final Database db = await database;
    String idMain = "BK${transaksiKasKeluar.idTransaksiKasKeluar.substring(2)}";
    final dataTrans = TransaksiKas(
        idTransaksiKas: idMain,
        tanggal: transaksiKasKeluar.tanggal,
        kasMasuk: 0,
        kasKeluar: transaksiKasKeluar.nominal,
        idDetailKas: transaksiKasKeluar.idTransaksiKasKeluar,
        idJenisKas: transaksiKasKeluar.idJenisKasKeluar,
        keterangan: transaksiKasKeluar.keterangan);
    await db.insert('transaksi_kas_keluar', transaksiKasKeluar.toMap());
    await db.insert('transaksi_kas', dataTrans.toMap());
    debugPrint("TransKasKeluar - Added");
    getOverview();
  }

  Future<List<TransaksiKasKeluar>> getTransaksiKasKeluar() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query('transaksi_kas_keluar');
    debugPrint("TransKasKeluar - Get All");
    return results.map((res) => TransaksiKasKeluar.fromMap(res)).toList();
  }

  Future<TransaksiKasKeluar> getTransaksiKasKeluarById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'transaksi_kas_keluar',
      where: 'idTransaksiKasKeluar = ?',
      whereArgs: [id],
    );
    debugPrint("TransKasKeluar - Get By Id $id");
    // return results.map((res) => TransaksiKasKeluar.fromMap(res)).first;
    if (results.isEmpty) {
      return TransaksiKasKeluar(
          idTransaksiKasKeluar: '-',
          tanggal: '',
          idJenisKasKeluar: '',
          idAsisten: '',
          penerima: '',
          nominal: 0,
          keterangan: '');
    } else {
      return results.map((res) => TransaksiKasKeluar.fromMap(res)).first;
    }
  }

  Future<String> getTotalKasKeluar() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db
        .rawQuery('SELECT SUM(nominal) as TotalAll FROM transaksi_kas_keluar;');
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['TotalAll'].toString();
    }
  }

  Future<String> getTotalKasKeluarToday(String tanggal) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(nominal) as Total FROM transaksi_kas_keluar where tanggal like '%$tanggal%';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<String> getTotalKasKeluarWeekly(String tanggal) async {
    final DateTime dateTo = DateTime.parse(tanggal);
    final DateTime dateFrom =
        DateTime(dateTo.year, dateTo.month, dateTo.day + 6);
    final String to = DateFormat('yyyy-MM-dd').format(dateTo);
    final String from = DateFormat('yyyy-MM-dd').format(dateFrom);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(nominal) as Total FROM transaksi_kas_keluar where tanggal >= '$dateFrom' and tanggal <= '$dateTo';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<String> getTotalKasKeluarMonthly(String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy-MM').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(nominal) as Total FROM transaksi_kas_keluar where tanggal like '%$inDate%';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<String> getTotalKasKeluarYearly(String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(nominal) as Total FROM transaksi_kas_keluar where tanggal like '%$inDate%';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<List<TransaksiKasKeluar>> getTransaksiKasKeluarToday(
      String tanggal) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM transaksi_kas_keluar WHERE tanggal like '%$tanggal%';");
    debugPrint("TransKasKeluar - Hari ini $tanggal");
    return results.map((res) => TransaksiKasKeluar.fromMap(res)).toList();
  }

  Future<List<TransaksiKasKeluar>> getTransaksiKasKeluarWeekly(
      String tanggal) async {
    final DateTime dateTo = DateTime.parse(tanggal);
    final DateTime dateFrom =
        DateTime(dateTo.year, dateTo.month, dateTo.day + 6);
    final String to = DateFormat('yyyy-MM-dd').format(dateTo);
    final String from = DateFormat('yyyy-MM-dd').format(dateFrom);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'transaksi_kas_keluar',
      where: 'tanggal >= ? and tanggal <= ?',
      whereArgs: [dateFrom, dateTo],
    );
    debugPrint("TransKasKeluar - Minggu ini $from - $to");
    return results.map((res) => TransaksiKasKeluar.fromMap(res)).toList();
  }

  Future<List<TransaksiKasKeluar>> getTransaksiKasKeluarMonthly(
      String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy-MM').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM transaksi_kas_keluar WHERE tanggal like '%$inDate%';");
    debugPrint("TransKasKeluar - Bulan ini $inDate");
    return results.map((res) => TransaksiKasKeluar.fromMap(res)).toList();
  }

  Future<List<TransaksiKasKeluar>> getTransaksiKasKeluarYearly(
      String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM transaksi_kas_keluar WHERE tanggal like '%$inDate%';");
    debugPrint("TransKasKeluar - Tahun ini $inDate");
    return results.map((res) => TransaksiKasKeluar.fromMap(res)).toList();
  }

  Future<void> updateTransaksiKasKeluar(
      TransaksiKasKeluar transaksiKasKeluar) async {
    final Database db = await database;
    final dataTransBefore = await getTransaksiKasByDetailId(
        transaksiKasKeluar.idTransaksiKasKeluar);
    final dataTransAfter = TransaksiKas(
        idTransaksiKas: dataTransBefore.idTransaksiKas,
        tanggal: transaksiKasKeluar.tanggal,
        kasMasuk: 0,
        kasKeluar: transaksiKasKeluar.nominal,
        idDetailKas: transaksiKasKeluar.idTransaksiKasKeluar,
        idJenisKas: transaksiKasKeluar.idJenisKasKeluar,
        keterangan: transaksiKasKeluar.keterangan);
    await db.update(
      'transaksi_kas_keluar',
      transaksiKasKeluar.toMap(),
      where: 'idTransaksiKasKeluar = ?',
      whereArgs: [transaksiKasKeluar.idTransaksiKasKeluar],
    );
    await db.update(
      'transaksi_kas',
      dataTransAfter.toMap(),
      where: 'idDetailKas = ?',
      whereArgs: [transaksiKasKeluar.idTransaksiKasKeluar],
    );
    debugPrint(
        "TransKasKeluar - ${transaksiKasKeluar.idTransaksiKasKeluar} Updated");
    TransaksiKeluarDetailPage.transaksiNotifier.value = transaksiKasKeluar;
    getOverview();
  }

  Future<void> deleteTransaksiKasKeluar(String id) async {
    final Database db = await database;
    await db.delete(
      'transaksi_kas_keluar',
      where: 'idTransaksiKasKeluar = ?',
      whereArgs: [id],
    );
    await db.delete(
      'transaksi_kas',
      where: 'idDetailKas = ?',
      whereArgs: [id],
    );
    debugPrint("TransKasKeluar - Id $id Removed");
    getOverview();
  }

  // =============================================================================================================

  Future<void> insertTransaksiKas(TransaksiKas transaksiKas) async {
    final Database db = await database;
    await db.insert('transaksi_kas', transaksiKas.toMap());
    debugPrint("BukuKas - Added");
    getOverview();
  }

  Future<List<TransaksiKas>> getTransaksiKas() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query('transaksi_kas');
    debugPrint("BukuKas - Get All");
    return results.map((res) => TransaksiKas.fromMap(res)).toList();
  }

  Future<TransaksiKas> getTransaksiKasById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'transaksi_kas',
      where: 'idTransaksiKas = ?',
      whereArgs: [id],
    );
    debugPrint("BukuKas - Get By Id $id");
    if (results.isEmpty) {
      return TransaksiKas(
          idTransaksiKas: '-',
          tanggal: '',
          kasMasuk: 0,
          kasKeluar: 0,
          idDetailKas: '',
          idJenisKas: '',
          keterangan: '');
    } else {
      return results.map((res) => TransaksiKas.fromMap(res)).first;
    }
  }

  Future<TransaksiKas> getTransaksiKasByDetailId(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'transaksi_kas',
      where: 'idDetailKas = ?',
      whereArgs: [id],
    );
    debugPrint("BukuKas - Get By Detail Id $id");
    if (results.isEmpty) {
      return TransaksiKas(
          idTransaksiKas: '-',
          tanggal: '',
          kasMasuk: 0,
          kasKeluar: 0,
          idDetailKas: '',
          idJenisKas: '',
          keterangan: '');
    } else {
      return results.map((res) => TransaksiKas.fromMap(res)).first;
    }
  }

  Future<String> getTotalKas() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT SUM(kasMasuk-kasKeluar) as TotalAll FROM transaksi_kas;');
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['TotalAll'].toString();
    }
  }

  Future<String> getTotalKasToday(String tanggal) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(kasMasuk-kasKeluar) as Total FROM transaksi_kas where tanggal like '%$tanggal%';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<String> getTotalKasWeekly(String tanggal) async {
    final DateTime dateTo = DateTime.parse(tanggal);
    final DateTime dateFrom =
        DateTime(dateTo.year, dateTo.month, dateTo.day + 6);
    final String to = DateFormat('yyyy-MM-dd').format(dateTo);
    final String from = DateFormat('yyyy-MM-dd').format(dateFrom);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(kasMasuk-kasKeluar) as Total FROM transaksi_kas where tanggal >= '$dateFrom' and tanggal <= '$dateTo';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<String> getTotalKasMonthly(String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy-MM').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(kasMasuk-kasKeluar) as Total FROM transaksi_kas where tanggal like '%$inDate%';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<String> getTotalKasYearly(String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT SUM(kasMasuk-kasKeluar) as Total FROM transaksi_kas where tanggal like '%$inDate%';");
    if (results.isEmpty) {
      return '';
    } else {
      return results[0]['Total'].toString();
    }
  }

  Future<List<TransaksiKas>> getTransaksiToday(String tanggal) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM transaksi_kas WHERE tanggal like '%$tanggal%';");
    debugPrint("BukuKas - Hari ini $tanggal");
    return results.map((res) => TransaksiKas.fromMap(res)).toList();
  }

  Future<List<TransaksiKas>> getTransaksiWeekly(String tanggal) async {
    final DateTime dateTo = DateTime.parse(tanggal);
    final DateTime dateFrom =
        DateTime(dateTo.year, dateTo.month, dateTo.day + 6);
    final String to = DateFormat('yyyy-MM-dd').format(dateTo);
    final String from = DateFormat('yyyy-MM-dd').format(dateFrom);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'transaksi_kas',
      where: 'tanggal >= ? and tanggal <= ?',
      whereArgs: [dateFrom, dateTo],
    );
    debugPrint("BukuKas - Minggu ini $from - $to");
    return results.map((res) => TransaksiKas.fromMap(res)).toList();
  }

  Future<List<TransaksiKas>> getTransaksiMonthly(String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy-MM').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM transaksi_kas WHERE tanggal like '%$inDate%';");
    debugPrint("BukuKas - Bulan ini $inDate");
    return results.map((res) => TransaksiKas.fromMap(res)).toList();
  }

  Future<List<TransaksiKas>> getTransaksiYearly(String tanggal) async {
    final DateTime dateIn = DateTime.parse(tanggal);
    final String inDate = DateFormat('yyyy').format(dateIn);
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM transaksi_kas WHERE tanggal like '%$inDate%';");
    debugPrint("BukuKas - Tahun ini $inDate");
    return results.map((res) => TransaksiKas.fromMap(res)).toList();
  }

  Future<void> updateTransaksiKas(TransaksiKas transaksiKas) async {
    final Database db = await database;
    await db.update(
      'transaksi_kas',
      transaksiKas.toMap(),
      where: 'idTransaksiKas = ?',
      whereArgs: [transaksiKas.idTransaksiKas],
    );
    debugPrint("BukuKas - ${transaksiKas.idTransaksiKas} Updated");
    getOverview();
  }

  Future<void> deleteTransaksiKas(String id) async {
    final Database db = await database;
    await db.delete(
      'transaksi_kas',
      where: 'idTransaksiKas = ?',
      whereArgs: [id],
    );
    debugPrint("BukuKas - Id $id Removed");
    getOverview();
  }
}
