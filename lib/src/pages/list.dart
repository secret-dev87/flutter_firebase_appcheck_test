import 'package:flutter_firebase_appcheck_test/model/employee_model.dart';
import 'package:flutter_firebase_appcheck_test/services/employees_service.dart';
import 'package:flutter/material.dart';

class LIST extends StatelessWidget {
  const LIST({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GET data")),
      body: FutureBuilder(
        future: EmployeesService.getEmployees(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Employee> data = snapshot.data;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(data[index].employeeName),
                  subtitle: Text(data[index].department),
                  trailing: Text("${data[index].dateOfJoining}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
