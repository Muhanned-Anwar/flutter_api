import 'package:flutter_api/models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentPreferenceController {
  static final StudentPreferenceController _instance =
      StudentPreferenceController._internal();

  late SharedPreferences _sharedPreferences;

  factory StudentPreferenceController() {
    return _instance;
  }

  StudentPreferenceController._internal();

  Future<void> initSharePreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveStudent({required Student student}) async {
    _sharedPreferences.setBool('logged_in', true);
    _sharedPreferences.setInt('id', student.id);
    _sharedPreferences.setString('fullName', student.fullName);
    _sharedPreferences.setString('email', student.email);
    _sharedPreferences.setString('gender', student.gender);
    _sharedPreferences.setString('token', "Bearer ${student.token}");
    _sharedPreferences.setString('refreshToken', student.refreshToken);
    _sharedPreferences.setBool('isActive', student.isActive);
  }

  bool get loggedIn => _sharedPreferences.getBool('logged_in') ?? false;

  String get token => _sharedPreferences.getString('token') ?? '';

  Future<bool> logout() async {
    return await _sharedPreferences.clear();
    return true;
  }


}
