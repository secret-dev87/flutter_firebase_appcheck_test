import 'package:flutter_firebase_appcheck_test/services/users_service.dart';
import 'package:flutter/material.dart';
import 'list.dart';

class CREATE extends StatefulWidget {
  const CREATE({super.key});

  @override
  State<CREATE> createState() => _POSTState();
}

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

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
                decoration: const InputDecoration(label: Text("Name")),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(label: Text("Email")),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: password,
                decoration: const InputDecoration(label: Text("Password")),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    var data = {
                      "name": name.text,
                      "email": email.text,
                      "password": password.text
                    };

                    UsersService.postUser(data);

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const LIST();
                      },
                    ));
                  },
                  child: const Text("POST"))
            ],
          ),
        ),
      ),
    );
  }
}
