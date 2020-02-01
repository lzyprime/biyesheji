import 'package:client/views/user_widgets/edit_user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/view_models/user_view_model.dart';
import 'package:client/views/auth_widgets/auth_widget.dart';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserViewModel>(context);
    if (viewModel.userData != null)
      return ListView(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: CircleAvatar(
                          radius: 50, backgroundColor: Colors.black45),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(viewModel.userData.username,
                            style: Theme.of(context).textTheme.headline),
                        Text(viewModel.userData.email,
                            style: Theme.of(context).textTheme.subhead),
                      ],
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: Icon(Icons.edit, size: 16),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(EditUserInfoWidget.routeName)
                                      .then((res) {
                                    if (res == true) viewModel.getUserInfo();
                                  });
                                })))
                  ],
                )
              ],
            ),
          ),
          Card(
              child: ListTile(
            title: FlatButton(
                child: Text(S.of(context).logout,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).accentColor)),
                onPressed: viewModel.logout),
          ))
        ],
      );
    return Center(
      child: viewModel.loading
          ? SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            )
          : RaisedButton(
              child: Text(viewModel.hadLogin
                  ? S.of(context).reloading
                  : "${S.of(context).login}/${S.of(context).register}"),
              onPressed: () {
                if (viewModel.hadLogin) {
                  viewModel.getUserInfo();
                  return;
                }
                Navigator.of(context)
                    .pushNamed(AuthWidget.routeName)
                    .then((res) {
                  viewModel.uid = res ?? 0;
                  viewModel.getUserInfo();
                });
              }),
    );
  }
}
