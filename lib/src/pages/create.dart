import 'package:flutter_firebase_appcheck_test/services/users_service.dart';
import 'package:flutter/material.dart';

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
                obscureText: true,
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

                    _createUser(context, data);
                  },
                  child: const Text("POST"))
            ],
          ),
        ),
      ),
    );
  }

  _createUser(context, Map userdata) async {
    var message = "";
    try {
      var res = await UsersService.postUser(userdata);
      if (res.statusCode == 200) {
        message = "New user is created.";
      } else {
        message = res.statusMessage;
      }
    } catch (e) {
      message = e.toString();
    }

    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        });
    AlertDialog alert = AlertDialog(
      title: Text("Creating User"),
      content: Text(message),
      actions: [okButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
