import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_api/api/api_settings.dart';
import 'package:flutter_api/models/student_image.dart';
import 'package:flutter_api/prefs/student_preferences_controller.dart';
import 'package:flutter_api/utils/helpers.dart';
import 'package:http/http.dart' as http;

typedef ImageUploadResponse = void Function({
  required bool status,
  StudentImage? studentImage,
  required String message,
});

class ImagesApiController with Helpers {
  Future<List<StudentImage>> images() async {
    var url = Uri.parse(ApiSettings.IMAGES.replaceFirst('{id}', ''));
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: StudentPreferenceController().token
    });

    if (response.statusCode == 200) {
      var dataJsonArray = jsonDecode(response.body)['data'] as List;
      return dataJsonArray.map((e) => StudentImage.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> uploadImage({
    required String filePath,
    required ImageUploadResponse imageUploadResponse,
  }) async {
    var url = Uri.parse(ApiSettings.IMAGES.replaceFirst('/{id}', ''));
    var request = http.MultipartRequest('POST', url);
    var file = await http.MultipartFile.fromPath('image', filePath);
    request.files.add(file);
    request.headers[HttpHeaders.authorizationHeader] =
        StudentPreferenceController().token;
    // request.fields['name'] = ''; //This if you need send another data to api

    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((String event) {
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(event);
        StudentImage studentImage = StudentImage.fromJson(jsonResponse['data']);
        imageUploadResponse(
          status: true,
          studentImage: studentImage,
          message: jsonResponse['message'],
        );
      } else if (response.statusCode == 400) {
        var jsonResponse = jsonDecode(event);
        StudentImage studentImage = StudentImage.fromJson(jsonResponse['data']);
        imageUploadResponse(
          status: false,
          studentImage: studentImage,
          message: jsonResponse['message'],
        );
      } else {
        imageUploadResponse(
            status: false, message: 'Something went wrong!, try again');
      }
    });
  }

  Future<bool> deleteImage(
      {required BuildContext context, required int id}) async {
    var url = Uri.parse(ApiSettings.IMAGES.replaceFirst('{id}', id.toString()));
    var response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: StudentPreferenceController().token
    });
    if (response.statusCode == 200) {
      showSnackBar(
          context: context, message: jsonDecode(response.body)['message']);
      return true;
    } else {
      return false;
    }
  }
}
