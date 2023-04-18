import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/material.dart';

class JenisKasDetailProvider extends ChangeNotifier {
  JenisKas _jenisKas = JenisKas(idJenisKas: '', namaJenisKas: '', status: '', warna: 0, ikon: '');
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  JenisKas get result => _jenisKas;
  ResultStateDb get state => _state;

  JenisKasDetailProvider(String id) {
    _dbHelper = DatabaseHelper();
    _fetchDetailJenisKas(id);
  }

  Future<dynamic> _fetchDetailJenisKas(String id) async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final jenisKas = await _dbHelper.getJenisKasById(id);
      if (jenisKas.idJenisKas == '-') {
        _state = ResultStateDb.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _jenisKas = jenisKas;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
