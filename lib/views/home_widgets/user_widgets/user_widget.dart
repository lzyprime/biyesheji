import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/views/auth_widgets/logout_dialog.dart';
import 'package:client/globals/route.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/view_models/user_view_model.dart';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserViewModel>(context);
    if (viewModel.userData == null)
      return FlatButton(
        child: Text("${S.of(context).login}/${S.of(context).register}"),
        onPressed: () {
          Navigator.of(context).pushNamed(R.login);
        },
      );
    return ListView(
      children: <Widget>[
        Card(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).accentColor)),
                  child: viewModel.userData.avatar == null
                      ? CircleAvatar(
                          radius: 50,
                          child: FlutterLogo(size: 50),
                          backgroundColor: Colors.transparent)
                      : CircleAvatar(
                          radius: 50, backgroundColor: Colors.black45),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(viewModel.userData.username,
                      style: Theme.of(context).textTheme.display1),
                  Text(viewModel.userData.email),
                ],
              ),
              Expanded(
                  child: ButtonBar(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.edit, size: 16),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(R.editUerInfo)
                            .then((res) {});
                      }),
                ],
              ))
            ],
          ),
        ),
        Card(
            child: ListTile(
          title: FlatButton(
              child: Text(S.of(context).logout,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).accentColor)),
              onPressed: () =>
                  showDialog(context: context, builder: (_) => LogoutDialog())),
        ))
      ],
    );
  }
}
