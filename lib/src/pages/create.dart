import 'package:flutter_firebase_appcheck_test/services/employees_service.dart';
import 'package:flutter/material.dart';

class CREATE extends StatefulWidget {
  const CREATE({super.key});

  @override
  State<CREATE> createState() => _POSTState();
}

TextEditingController name = TextEditingController();
TextEditingController department = TextEditingController();
TextEditingController joineddate = TextEditingController();

class _POSTState extends State<CREATE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(label: Text("Employee-name")),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: department,
                decoration:
                    const InputDecoration(label: Text("Department-name")),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: joineddate,
                decoration: const InputDecoration(label: Text("Joined-date")),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    var data = {
                      "employeeName": name.text,
                      "department": department.text,
                      "dateOfJoining": joineddate.text
                    };

                    EmployeesService.postEmployee(data);
                  },
                  child: const Text("POST"))
            ],
          ),
        ),
      ),
    );
  }
}
