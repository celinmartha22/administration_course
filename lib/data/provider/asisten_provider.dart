import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/asisten.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AsistenProvider extends ChangeNotifier {
  List<Asisten> _asisten = [];
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  List<Asisten> get result => _asisten;
  ResultStateDb get state => _state;

  List<Asisten> get favorites => _asisten;
  AsistenProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllAsisten();
  }

  Future<dynamic> _fetchAllAsisten() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final asisten = await _dbHelper.getAsisten();
      if (asisten.isEmpty) {
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

  Future<Asisten> getAsistenById(String id) async {
    return await _dbHelper.getAsistenById(id);
  }

  Future<void> addAsisten(Asisten asisten) async {
    await _dbHelper.insertAsisten(asisten);
    _fetchAllAsisten();
  }

  Future<void> updateAsisten(Asisten asisten) async {
    await _dbHelper.updateAsisten(asisten);
    _fetchAllAsisten();
  }

  void deleteAsisten(String id) async {
    await _dbHelper.deleteAsisten(id);
    _fetchAllAsisten();
  }
}
