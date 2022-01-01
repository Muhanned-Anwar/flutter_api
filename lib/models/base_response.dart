import 'package:flutter_api/models/user.dart';

class BaseResponse<T> {
  late bool status;
  late String message;
  late List<T> list;

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      if (T == User) {
        list = <T>[];
        json['list'].forEach((v) {
          list.add(User.fromJson(v) as T);
        });
      }
    }
  }
}
