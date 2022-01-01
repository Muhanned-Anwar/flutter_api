import 'dart:convert';
import 'package:flutter_api/api/api_settings.dart';
import 'package:flutter_api/models/base_response.dart';
import 'package:flutter_api/models/user.dart';
import 'package:http/http.dart' as http;


class UsersApiController {

  Future<List<User>> getUsers() async {
    var url = Uri.parse(ApiSettings.USERS); // Convert Text to UrI
    var response = await http.get(url);

    if(response.statusCode == 200){
      BaseResponse<User> baseResponse = BaseResponse.fromJson(jsonDecode(response.body));
      return baseResponse.list;
    }else if(response.statusCode == 400){
      //
    }else{
      //
    }
    return [];
  }
}
