import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserAllProvider extends ChangeNotifier {
  List<User> _user = [];
  late DatabaseHelper _dbHelper;

  late ResultStateDb _state;
  String _message = '';
  String get message => _message;
  List<User> get result => _user;
  ResultStateDb get state => _state;

  List<User> get userList => _user;
  UserAllProvider() {
    _dbHelper = DatabaseHelper();
    _fetchAllUser();
  }

  Future<dynamic> _fetchAllUser() async {
    try {
      _state = ResultStateDb.loading;
      notifyListeners();
      final user = await _dbHelper.getUser();
      if (user.isEmpty) {
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

  Future<User> getUserById(String id) async {
    return await _dbHelper.getUserById(id);
  }

  Future<User> getUserByUserPass(String user, String pass) async {
    return await _dbHelper.getUserByUserPass(user, pass);
  }

  Future<User> getActiveUser() async {
    return await _dbHelper.getActiveUser();
  }

  Future<void> addUser(User user) async {
    await _dbHelper.insertUser(user);
    _fetchAllUser();
  }

  Future<void> updateUserBio(User user) async {
    await _dbHelper.updateUserBio(user);
    _fetchAllUser();
  }

  Future<void> updateUserStatus(String id, int status) async {
    await _dbHelper.updateUserStatus(id, status);
    _fetchAllUser();
  }

  void deleteUser(String id) async {
    await _dbHelper.deleteUser(id);
    _fetchAllUser();
  }
}
