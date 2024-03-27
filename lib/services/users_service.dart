import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_firebase_appcheck_test/model/user_model.dart';
import 'package:dio/dio.dart';

class UsersService {
  static String url = "http://172.17.100.2:3000/api/";
  // static String url = "http://localhost:3000/api/";

  static postUser(Map pdata) async {
    final dio = Dio();
    final res = await dio.post("${url}users",
        data: jsonEncode(pdata),
        options: Options(headers: {
          "X-Firebase-AppCheck": await FirebaseAppCheck.instance.getToken(),
          "content-type": "application/json",
          "accept": "application/json",
        }));

    return res;
  }

  static getUsers() async {
    final dio = Dio();
    final res = await dio.get("${url}users",
        options: Options(headers: {
          "X-Firebase-AppCheck": await FirebaseAppCheck.instance.getToken(),
          "content-type": "application/json",
          "accept": "application/json",
        }));

    return res;
  }
}
