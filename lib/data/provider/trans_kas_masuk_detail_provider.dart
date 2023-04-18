import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/transaksi_kas_masuk.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/material.dart';

class TransKasMasukDetailProvider extends ChangeNotifier {
  TransaksiKasMasuk _transKasMasuk = TransaksiKasMasuk(
      idTransaksiKasMasuk: '',
      tanggal: '',
      idJenisKasMasuk: '',
      idSiswa: '',
      pembayar: '',
      idPaketKursus: '',
      nominal: 0,
      keterangan: '');
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  TransaksiKasMasuk get result => _transKasMasuk;
  ResultStateDb get state => _state;

  TransKasMasukDetailProvider(String id) {
    _dbHelper = DatabaseHelper();
    _fetchDetailTransKasMasuk(id);
  }

  Future<dynamic> _fetchDetailTransKasMasuk(String id) async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final transKasMasuk = await _dbHelper.getTransaksiKasMasukById(id);
      if (transKasMasuk.idTransaksiKasMasuk == '-') {
        _state = ResultStateDb.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _transKasMasuk = transKasMasuk;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
