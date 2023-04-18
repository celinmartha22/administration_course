import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/transaksi_kas_keluar.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TransKasKeluarProvider extends ChangeNotifier {
  List<TransaksiKasKeluar> _transKasKeluar = [];
  String _total = '0';
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  List<TransaksiKasKeluar> get result => _transKasKeluar;
  ResultStateDb get state => _state;

  String get total => _total;

  TransKasKeluarProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllTransKasKeluar();
  }

  Future<dynamic> _fetchAllTransKasKeluar() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final trans = await _dbHelper.getTransaksiKasKeluar();
      final summary = await _dbHelper.getTotalKasKeluar();
      if (trans.isEmpty) {
        _state = ResultStateDb.noData;
        _total = summary;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        _total = summary;
        notifyListeners();
        return _transKasKeluar = trans;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<List<TransaksiKasKeluar>> getAllTransaksiKasKeluar() async {
    return await _dbHelper.getTransaksiKasKeluar();
  }

  Future<TransaksiKasKeluar> getTransaksiKasKeluarById(String id) async {
    return await _dbHelper.getTransaksiKasKeluarById(id);
  }

  Future<List<TransaksiKasKeluar>> getTransaksiToday(String tanggal) async {
    return await _dbHelper.getTransaksiKasKeluarToday(tanggal);
  }

  Future<List<TransaksiKasKeluar>> getTransaksiWeekly(String tanggal) async {
    return await _dbHelper.getTransaksiKasKeluarWeekly(tanggal);
  }

  Future<List<TransaksiKasKeluar>> getTransaksiMonthly(String tanggal) async {
    return await _dbHelper.getTransaksiKasKeluarMonthly(tanggal);
  }

  Future<List<TransaksiKasKeluar>> getTransaksiYearly(String tanggal) async {
    return await _dbHelper.getTransaksiKasKeluarYearly(tanggal);
  }

  Future<void> addTransKas(TransaksiKasKeluar trans) async {
    await _dbHelper.insertTransaksiKasKeluar(trans);
    _fetchAllTransKasKeluar();
  }

  Future<void> updateTransKas(TransaksiKasKeluar trans) async {
    await _dbHelper.updateTransaksiKasKeluar(trans);
    _fetchAllTransKasKeluar();
  }

  void deleteTransKas(String id) async {
    await _dbHelper.deleteTransaksiKasKeluar(id);
    _fetchAllTransKasKeluar();
  }

  Future<String> getTotalKas() async {
    return await _dbHelper.getTotalKasKeluar();
  }

  Future<String> getTotalKasToday(String tanggal) async {
    return await _dbHelper.getTotalKasKeluarToday(tanggal);
  }

  Future<String> getTotalKasWeekly(String tanggal) async {
    return await _dbHelper.getTotalKasKeluarWeekly(tanggal);
  }

  Future<String> getTotalKasMonthly(String tanggal) async {
    return await _dbHelper.getTotalKasKeluarMonthly(tanggal);
  }

  Future<String> getTotalKasYearly(String tanggal) async {
    return await _dbHelper.getTotalKasKeluarYearly(tanggal);
  }
}
