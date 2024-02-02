import 'dart:convert';

import 'package:flutter_firebase_appcheck_test/model/employee_model.dart';
import 'package:http/http.dart' as http;

class EmployeesService {
  static String url = "http://localhost:5192/api/";

  static postEmployee(Map pdata) async {
    try {
      final res = await http.post(Uri.parse(("${url}Employees")),
          body: jsonEncode(pdata),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          });

      if (res.statusCode == 200) {
        print(res.body);
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("Failed to load data");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getEmployees() async {
    List<Employee> employees = [];
    try {
      final res = await http.get(Uri.parse("${url}Employees"));

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) => {
              employees.add(
                Employee(
                    value["employeeId"],
                    value["employeeName"],
                    value["department"],
                    DateTime.parse(value["dateOfJoining"])),
              )
            });
        return employees;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
