import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/siswa.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SiswaProvider extends ChangeNotifier {
  List<Siswa> _siswa = [];
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  List<Siswa> get result => _siswa;
  ResultStateDb get state => _state;

  List<Siswa> get siswa => _siswa;
  SiswaProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllSiswa();
  }

  Future<dynamic> _fetchAllSiswa() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final siswa = await _dbHelper.getSiswa();
      if (siswa.isEmpty) {
        _state = ResultStateDb.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _siswa = siswa;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<Siswa> getSiswaById(String id) async {
    return await _dbHelper.getSiswaById(id);
  }

  Future<void> addSiswa(Siswa siswa) async {
    await _dbHelper.insertSiswa(siswa);
    _fetchAllSiswa();
  }

  Future<void> updateSiswa(Siswa siswa) async {
    await _dbHelper.updateSiswa(siswa);
    _fetchAllSiswa();
  }

  void deleteSiswa(String id) async {
    await _dbHelper.deleteSiswa(id);
    _fetchAllSiswa();
  }
}
