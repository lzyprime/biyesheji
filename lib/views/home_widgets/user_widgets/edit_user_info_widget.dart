import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/datas/user_data.dart';
class EditUserInfoWidget extends StatelessWidget {
  final UserData _userData;

  EditUserInfoWidget(this._userData);


  @override
  Widget build(BuildContext context) {
    final username = TextEditingController(text: _userData.username);
    final email = TextEditingController(text: _userData.email);

    return Scaffold(
      appBar: AppBar(title: Icon(Icons.edit)),
      body: ListView(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: username,
                ),
                TextField(
                  controller: email,
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
