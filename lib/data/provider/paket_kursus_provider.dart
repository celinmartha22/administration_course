import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/paket_kursus.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PaketKursusProvider extends ChangeNotifier {
  List<PaketKursus> _paketKursus = [];
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  List<PaketKursus> get result => _paketKursus;
  ResultStateDb get state => _state;

  List<PaketKursus> get favorites => _paketKursus;
  PaketKursusProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllPaketKursus();
  }

  Future<dynamic> _fetchAllPaketKursus() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final paketKursus = await _dbHelper.getPaketKursus();
      if (paketKursus.isEmpty) {
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

  Future<PaketKursus> getPaketKursusById(String id) async {
    return await _dbHelper.getPaketKursusById(id);
  }

  Future<void> addPaketKursus(PaketKursus paketKursus) async {
    await _dbHelper.insertPaketKursus(paketKursus);
    _fetchAllPaketKursus();
  }

  Future<void> updatePaketKursus(PaketKursus paketKursus) async {
    await _dbHelper.updatePaketKursus(paketKursus);
    _fetchAllPaketKursus();
  }

  void deletePaketKursus(String id) async {
    await _dbHelper.deletePaketKursus(id);
    _fetchAllPaketKursus();
  }
}
