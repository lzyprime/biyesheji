import 'package:client/globals/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/view_models/user_view_model.dart';

class EditUserInfoWidget extends StatelessWidget {
  static const routeName = 'EditUserInfoWidget';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserViewModel viewModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('${S.of(context).edit}${S.of(context).userInfo}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller..text = viewModel.username,
            decoration: InputDecoration(labelText: "username"),
          ),
          FlatButton(
            child: Text("submit"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
