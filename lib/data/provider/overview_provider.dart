import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/overview.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:administration_course/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class OverviewProvider extends ChangeNotifier {
  Overview _overview = Overview(
      totalKursus: 0,
      totalSiswa: 0,
      totalAsisten: 0,
      totalSaldoMasuk: 0,
      totalSaldoKeluar: 0,
      dataKasMasukKategori: [],
      dataKasKeluarKategori: []);
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  Overview get result => _overview;
  ResultStateDb get state => _state;

  Overview get favorites => _overview;
  OverviewProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllOverview();
  }

  Future<dynamic> _fetchAllOverview() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final overview = await _dbHelper.getOverview();
      if (overview.totalKursus != 0 ||
          overview.totalSiswa != 0 ||
          overview.totalAsisten != 0 ||
          overview.totalSaldoMasuk != 0 ||
          overview.totalSaldoKeluar != 0 ||
          overview.dataKasMasukKategori != [] ||
          overview.dataKasKeluarKategori != []) {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _overview = overview;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<Overview> getRecentOverview() async {
    return await _dbHelper.getOverview();
  }
}
