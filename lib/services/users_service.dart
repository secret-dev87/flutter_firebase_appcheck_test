import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_firebase_appcheck_test/model/user_model.dart';
import 'package:dio/dio.dart';

class UsersService {
  static String url = "http://172.17.100.2:3000/api/";
  // static String url = "http://localhost:3000/api/";

  static postUser(Map pdata) async {
    final _dio = Dio();
    print("Post User");

    try {
      final res = await _dio.post("${url}users",
          data: jsonEncode(pdata),
          options: Options(headers: {
            "X-Firebase-AppCheck": await FirebaseAppCheck.instance.getToken(),
            "content-type": "application/json",
            "accept": "application/json",
          }));

      if (res.statusCode == 200) {
        print(res.data);
        var data = jsonDecode(res.data.toString());
        print(data);
      } else {
        print("Failed to Create User");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getUsers() async {
    final _dio = Dio();
    print("Get Users");

    try {
      List<User> users = [];

      final res = await _dio.get("${url}users",
          options: Options(headers: {
            "X-Firebase-AppCheck": await FirebaseAppCheck.instance.getToken(),
            "content-type": "application/json",
            "accept": "application/json",
          }));

      if (res.statusCode == 200) {
        var data = res.data;
        data.forEach((value) => {
              users.add(User(value["id"], value["name"], value["email"],
                  value["password"]))
            });
        return users;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
