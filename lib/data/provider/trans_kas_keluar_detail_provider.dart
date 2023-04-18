import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/transaksi_kas_keluar.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/material.dart';

class TransKasKeluarDetailProvider extends ChangeNotifier {
  TransaksiKasKeluar _transKasKeluar = TransaksiKasKeluar(
      idTransaksiKasKeluar: '',
      tanggal: '',
      idJenisKasKeluar: '',
      idAsisten: '',
      penerima: '',
      nominal: 0,
      keterangan: '');
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  TransaksiKasKeluar get result => _transKasKeluar;
  ResultStateDb get state => _state;

  TransKasKeluarDetailProvider(String id) {
    _dbHelper = DatabaseHelper();
    _fetchDetailTransKasKeluar(id);
  }

  Future<dynamic> _fetchDetailTransKasKeluar(String id) async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final transKasKeluar = await _dbHelper.getTransaksiKasKeluarById(id);
      if (transKasKeluar.idTransaksiKasKeluar == '-') {
        _state = ResultStateDb.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _transKasKeluar = transKasKeluar;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<void> updateTransKas(TransaksiKasKeluar trans) async {
    await _dbHelper.updateTransaksiKasKeluar(trans);
    _fetchDetailTransKasKeluar(trans.idTransaksiKasKeluar);
  }
}
