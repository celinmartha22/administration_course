import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/transaksi_kas.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TransKasProvider extends ChangeNotifier {
  List<TransaksiKas> _transKas = [];
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  List<TransaksiKas> get result => _transKas;
  ResultStateDb get state => _state;

  List<TransaksiKas> get favorites => _transKas;
  TransKasProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllTransKas();
  }

  Future<dynamic> _fetchAllTransKas() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final trans = await _dbHelper.getTransaksiKas();
      if (trans.isEmpty) {
        _state = ResultStateDb.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _transKas = trans;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<List<TransaksiKas>> getAllTransaksiKas() async {
    return await _dbHelper.getTransaksiKas();
  }

  Future<TransaksiKas> getTransaksiKasById(String id) async {
    return await _dbHelper.getTransaksiKasById(id);
  }

  Future<List<TransaksiKas>> getTransaksiToday(String tanggal) async {
    return await _dbHelper.getTransaksiToday(tanggal);
  }

  Future<List<TransaksiKas>> getTransaksiWeekly(String tanggal) async {
    return await _dbHelper.getTransaksiWeekly(tanggal);
  }

  Future<List<TransaksiKas>> getTransaksiMonthly(String tanggal) async {
    return await _dbHelper.getTransaksiMonthly(tanggal);
  }

  Future<List<TransaksiKas>> getTransaksiYearly(String tanggal) async {
    return await _dbHelper.getTransaksiYearly(tanggal);
  }

  Future<void> addTransKas(TransaksiKas trans) async {
    await _dbHelper.insertTransaksiKas(trans);
    _fetchAllTransKas();
  }

  Future<void> updateTransKas(TransaksiKas trans) async {
    await _dbHelper.updateTransaksiKas(trans);
    _fetchAllTransKas();
  }

  void deleteTransKas(String id) async {
    await _dbHelper.deleteTransaksiKas(id);
    _fetchAllTransKas();
  }

  Future<String> getTotalKas() async {
    return await _dbHelper.getTotalKas();
  }

  Future<String> getTotalKasToday(String tanggal) async {
    return await _dbHelper.getTotalKasToday(tanggal);
  }

  Future<String> getTotalKasWeekly(String tanggal) async {
    return await _dbHelper.getTotalKasWeekly(tanggal);
  }

  Future<String> getTotalKasMonthly(String tanggal) async {
    return await _dbHelper.getTotalKasMonthly(tanggal);
  }

  Future<String> getTotalKasYearly(String tanggal) async {
    return await _dbHelper.getTotalKasYearly(tanggal);
  }
}
