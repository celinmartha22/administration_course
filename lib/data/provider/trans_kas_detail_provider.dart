import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/transaksi_kas.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/material.dart';

class TransKasDetailProvider extends ChangeNotifier {
  TransaksiKas _transKas = TransaksiKas(
      idTransaksiKas: '',
      tanggal: '',
      kasMasuk: 0,
      kasKeluar: 0,
      idDetailKas: '',
      idJenisKas: '',
      keterangan: '');
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  TransaksiKas get result => _transKas;
  ResultStateDb get state => _state;

  TransKasDetailProvider(String id) {
    _dbHelper = DatabaseHelper();
    _fetchDetailTransKas(id);
  }

  Future<dynamic> _fetchDetailTransKas(String id) async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final transKas = await _dbHelper.getTransaksiKasById(id);
      if (transKas.idTransaksiKas == '-') {
        _state = ResultStateDb.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _transKas = transKas;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
