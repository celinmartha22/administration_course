import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class JenisKasProvider extends ChangeNotifier {
  List<JenisKas> _jenisKas = [];
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  List<JenisKas> get result => _jenisKas;
  ResultStateDb get state => _state;

  List<JenisKas> get favorites => _jenisKas;
  JenisKasProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllJenisKas();
  }

  Future<dynamic> _fetchAllJenisKas() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final jenisKas = await _dbHelper.getJenisKas();
      if (jenisKas.isEmpty) {
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

  Future<JenisKas> getJenisKasById(String id) async {
    return await _dbHelper.getJenisKasById(id);
  }

  Future<void> addJenisKas(JenisKas jenisKas) async {
    await _dbHelper.insertJenisKas(jenisKas);
    _fetchAllJenisKas();
  }

  Future<void> updateJenisKas(JenisKas jenisKas) async {
    await _dbHelper.updateJenisKas(jenisKas);
    _fetchAllJenisKas();
  }

  void deleteJenisKas(String id) async {
    await _dbHelper.deleteJenisKas(id);
    _fetchAllJenisKas();
  }
}
