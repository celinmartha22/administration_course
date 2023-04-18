import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/asisten.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/material.dart';

class AsistenDetailProvider extends ChangeNotifier {
  Asisten _asisten = Asisten(
        idAsisten: '',
        namaAsisten: '',
        jabatan: '',
        alamat: '',
        jenisKelamin: '',
        nomorHP: '');
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  Asisten get result => _asisten;
  ResultStateDb get state => _state;

  AsistenDetailProvider(String id) {
    _dbHelper = DatabaseHelper();
    _fetchDetailAsisten(id);
  }

  Future<dynamic> _fetchDetailAsisten(String id) async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final asisten = await _dbHelper.getAsistenById(id);
      if (asisten.idAsisten == '-') {
        _state = ResultStateDb.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _asisten = asisten;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
