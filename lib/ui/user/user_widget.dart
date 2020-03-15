import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/route.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/ui/user/view_model.dart';

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

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: viewModel.refresh,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () =>
                              Navigator.of(context).pushNamed(R.settings),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => viewModel.setAvatar(context),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              NetworkImage(viewModel.userData.avatar),
                        ),
                      ),
                    ),
                    Text(
                      "${viewModel.userData.username}",
                      style: Theme.of(context).textTheme.display3,
                    ),
                    Text(viewModel.userData.sexStr),
                    Text(
                      "${viewModel.userData.email}",
                      style: Theme.of(context).textTheme.headline,
                    ),
                    SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(R.favoriteAttention, arguments: 0),
                            child: Column(
                              children: <Widget>[
                                Text(S.of(context).post,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18)),
                                Text(viewModel.userData.postNum.toString()),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(R.favoriteAttention, arguments: 1),
                            child: Column(
                              children: <Widget>[
                                Text(S.of(context).favoritePost,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18)),
                                Text(viewModel.userData.favoriteNum.toString()),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(R.favoriteAttention, arguments: 2),
                            child: Column(
                              children: <Widget>[
                                Text(S.of(context).attention,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18)),
                                Text(
                                    viewModel.userData.attentionNum.toString()),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(R.favoriteAttention, arguments: 3),
                            child: Column(
                              children: <Widget>[
                                Text(S.of(context).follower,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18)),
                                Text(viewModel.userData.followerNum.toString()),
                              ],
                            ),
                          ),
                        ]),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Card(
                  child: ListTile(
                      title: Text(S.of(context).language),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {})),
              Card(
                  child: ListTile(
                      title: Text(S.of(context).theme),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {})),
              SizedBox(height: 20),
              Card(
                  child: FlatButton(
                      onPressed: () => viewModel.logout(context),
                      child: Text(S.of(context).logout))),
            ],
          ),
        ),
      ),
    );
  }
}
