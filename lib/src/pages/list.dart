import 'package:flutter_firebase_appcheck_test/model/user_model.dart';
import 'package:flutter_firebase_appcheck_test/services/users_service.dart';
import 'package:flutter/material.dart';

class LIST extends StatelessWidget {
  const LIST({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getUsers(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<User> data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(data[index].name),
                );
              },
            );
          }
        },
      ),
    );
  }

  _getUsers(context) async {
    var message = "";
    List<User> users = [];
    try {
      var res = await UsersService.getUsers();
      if (res.statusCode == 200) {
        var data = res.data;
        message = "";
        data.forEach((value) => {
              users.add(User(value["id"], value["name"], value["email"],
                  value["password"]))
            });
      } else {
        users = [];
        message = res.statusMessage;
      }
    } catch (e) {
      users = [];
      message = e.toString();
    }

    if (message.isNotEmpty) {
      Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          });

      AlertDialog alert = AlertDialog(
        title: Text("Users"),
        content: Text(message),
        actions: [okButton],
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }
    return users;
  }
}
