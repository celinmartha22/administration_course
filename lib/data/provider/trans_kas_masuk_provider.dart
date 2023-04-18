import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/transaksi_kas_masuk.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TransKasMasukProvider extends ChangeNotifier {
  List<TransaksiKasMasuk> _transKasMasuk = [];
  String _total = '0';
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  List<TransaksiKasMasuk> get result => _transKasMasuk;
  ResultStateDb get state => _state;

  String get total => _total;

  TransKasMasukProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllTransKasMasuk();
  }

  Future<dynamic> _fetchAllTransKasMasuk() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final trans = await _dbHelper.getTransaksiKasMasuk();
      final summary = await _dbHelper.getTotalKasMasuk();
      if (trans.isEmpty) {
        _state = ResultStateDb.noData;
        _total = summary;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        _total = summary;
        notifyListeners();
        return _transKasMasuk = trans;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<List<TransaksiKasMasuk>> getAllTransaksiKasMasuk() async {
    return await _dbHelper.getTransaksiKasMasuk();
  }

  Future<TransaksiKasMasuk> getTransaksiKasMasukById(String id) async {
    return await _dbHelper.getTransaksiKasMasukById(id);
  }

  Future<List<TransaksiKasMasuk>> getTransaksiToday(String tanggal) async {
    return await _dbHelper.getTransaksiMasukToday(tanggal);
  }

  Future<List<TransaksiKasMasuk>> getTransaksiWeekly(String tanggal) async {
    return await _dbHelper.getTransaksiMasukWeekly(tanggal);
  }

  Future<List<TransaksiKasMasuk>> getTransaksiMonthly(String tanggal) async {
    return await _dbHelper.getTransaksiMasukMonthly(tanggal);
  }

  Future<List<TransaksiKasMasuk>> getTransaksiYearly(String tanggal) async {
    return await _dbHelper.getTransaksiMasukYearly(tanggal);
  }

  Future<void> addTransKas(TransaksiKasMasuk trans) async {
    await _dbHelper.insertTransaksiKasMasuk(trans);
    _fetchAllTransKasMasuk();
  }

  Future<void> updateTransKas(TransaksiKasMasuk trans) async {
    await _dbHelper.updateTransaksiKasMasuk(trans);
    _fetchAllTransKasMasuk();
  }

  void deleteTransKas(String id) async {
    await _dbHelper.deleteTransaksiKasMasuk(id);
    _fetchAllTransKasMasuk();
  }

  Future<String> getTotalKas() async {
    return await _dbHelper.getTotalKasMasuk();
  }

  Future<String> getTotalKasToday(String tanggal) async {
    return await _dbHelper.getTotalKasMasukToday(tanggal);
  }

  Future<String> getTotalKasWeekly(String tanggal) async {
    return await _dbHelper.getTotalKasMasukWeekly(tanggal);
  }

  Future<String> getTotalKasMonthly(String tanggal) async {
    return await _dbHelper.getTotalKasMasukMonthly(tanggal);
  }

  Future<String> getTotalKasYearly(String tanggal) async {
    return await _dbHelper.getTotalKasMasukYearly(tanggal);
  }
}
