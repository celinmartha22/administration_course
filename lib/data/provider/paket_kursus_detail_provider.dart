import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/paket_kursus.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/material.dart';

class PaketKursusDetailProvider extends ChangeNotifier {
  PaketKursus _paketKursus = PaketKursus(
      idPaketKursus: '',
      namaPaketKursus: '',
      harga: 0,
      berlakuSelama: '',
      jenjang: '',
      keterangan: '');
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  PaketKursus get result => _paketKursus;
  ResultStateDb get state => _state;

  PaketKursusDetailProvider(String id) {
    _dbHelper = DatabaseHelper();
    _fetchDetailPaketKursus(id);
  }

  Future<dynamic> _fetchDetailPaketKursus(String id) async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final paketKursus = await _dbHelper.getPaketKursusById(id);
      if (paketKursus.idPaketKursus == '-') {
        _state = ResultStateDb.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _paketKursus = paketKursus;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
