import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:dio/dio.dart';

class UsersService {
  static String url = "http://45.61.141.31/api/";
  // static String url = "http://172.17.100.2:5192/api/";
  // static String url = "http://10.0.2.2:5192/api/";

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
