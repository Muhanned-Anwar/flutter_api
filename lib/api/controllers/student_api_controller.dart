import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_api/api/api_settings.dart';
import 'package:flutter_api/models/student.dart';
import 'package:flutter_api/prefs/student_preferences_controller.dart';
import 'package:flutter_api/utils/helpers.dart';
import 'package:http/http.dart' as http;

class StudentApiController with Helpers {
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse(ApiSettings.LOGIN);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Student student = Student.fromJson(jsonResponse['object']);
      StudentPreferenceController().saveStudent(student: student);
      return true;
    } else if (response.statusCode == 400) {
      //
    } else {
      //
    }
    return false;
  }

  Future<bool> logout() async {
    var url = Uri.parse(ApiSettings.LOGOUT);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: StudentPreferenceController().token,
      HttpHeaders.acceptHeader: 'application/json',
    });

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 401) {
      await StudentPreferenceController().logout();
      return true;
    }
    return false;
  }

  Future<bool> register({
    required BuildContext context,
    required String fullName,
    required String email,
    required String password,
    required String gender,
  }) async {
    var url = Uri.parse(ApiSettings.REGISTER);
    var response = await http.post(url, body: {
      'full_name': fullName,
      'email': email,
      'password': password,
      'gender': gender,
    });

    if (response.statusCode == 201) {
      showSnackBar(
          context: context, message: jsonDecode(response.body)['message']);
      return true;
    } else if ((response.statusCode == 400)) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'Something went wrong, please try again',
          error: true);
    }
    return false;
  }

  Future<bool> forgetPassword(
      {required BuildContext context, required String email}) async {
    var url = Uri.parse(ApiSettings.FORGET_PASSWORD);
    var response = await http.post(url, body: {'email': email});
    if (response.statusCode == 200) {
      showSnackBar(
          context: context,
          message:
              "${jsonDecode(response.body)['message']} = ${jsonDecode(response.body)['code']}",
          time: 5);
      print(jsonDecode(response.body)['code']);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return false;
    } else {
      showSnackBar(
          context: context, message: 'Something went wrong!', error: true);
    }
    return false;
  }

  Future<bool> resetPassword({
    required BuildContext context,
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    var url = Uri.parse(ApiSettings.RESET_PASSWORD);
    var response = await http.post(url, body: {
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    if (response.statusCode == 200) {
      showSnackBar(
          context: context, message: jsonDecode(response.body)['message']);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return false;
    } else {
      showSnackBar(
          context: context, message: 'Something went wrong!', error: true);
    }
    return false;
  }
}
