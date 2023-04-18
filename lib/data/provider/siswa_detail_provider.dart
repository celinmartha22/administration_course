import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/siswa.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/material.dart';

class SiswaDetailProvider extends ChangeNotifier {
  Siswa _siswa = Siswa(
      idSiswa: '-',
      namaSiswa: '',
      kelas: '',
      asalSekolah: '',
      jenisKelamin: '',
      tanggalLahir: '',
      tanggalMasuk: '',
      email: '',
      namaAyah: '',
      namaIbu: '',
      nomorHP: '',
      alamat: '');
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  Siswa get result => _siswa;
  ResultStateDb get state => _state;

  SiswaDetailProvider(String id) {
    _dbHelper = DatabaseHelper();
    _fetchDetailSiswa(id);
  }

  Future<dynamic> _fetchDetailSiswa(String id) async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final siswa = await _dbHelper.getSiswaById(id);
      if (siswa.idSiswa == '-') {
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
}
