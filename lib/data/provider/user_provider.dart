import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      idUser: '',
      username: '',
      password: '',
      name: '',
      email: '',
      loginStatus: 0);
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  User get result => _user;
  ResultStateDb get state => _state;

  User get userList => _user;
  UserProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllUser();
  }

  Future<dynamic> _fetchAllUser() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final user = await _dbHelper.getActiveUser();
      if (user.idUser == '') {
        _state = ResultStateDb.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDb.hasData;
        notifyListeners();
        return _user = user;
      }
    } catch (e) {
      _state = ResultStateDb.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<void> updateUser(User user) async {
    await _dbHelper.updateUserBio(user);
    _fetchAllUser();
  }
}
