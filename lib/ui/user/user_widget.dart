import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/datas/user_data.dart';
import 'package:client/globals/cache.dart';
import 'package:client/globals/route.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/ui/user/view_model.dart';
import 'package:provider/provider.dart';

class UserWidget extends StatelessWidget {
  final UserViewModel viewModel;

  UserWidget(UserData userData) : viewModel = UserViewModel(userData);

  @override
  Widget build(BuildContext context) {
    if (viewModel.userData == null)
      return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.of(context).pushNamed(R.settings),
            ),
          ],
        ),
        body: Center(
          child: FlatButton(
            child: Text("${S.of(context).login}/${S.of(context).register}"),
            onPressed: () => Navigator.of(context).pushNamed(R.login),
          ),
        ),
      );

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: Navigator.of(context).canPop()
            ? AppBar(
                title: Text(viewModel.userData?.username ?? ""),
                centerTitle: true,
              )
            : null,
        body: Consumer<UserViewModel>(
          builder: (context, viewModel, __) => SafeArea(
            child: RefreshIndicator(
              onRefresh: viewModel.refresh,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topRight,
                          child: Cache().userData?.id == viewModel.userData.id
                              ? IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(R.settings),
                                )
                              : _action(context),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                viewModel.userData.avatar.isNotEmpty
                                    ? NetworkImage(viewModel.userData.avatar)
                                    : null,
                            child: viewModel.userData.avatar.isEmpty
                                ? FlutterLogo(size: 50)
                                : null,
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
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: ListTile(
                      title: Text(S.of(context).post),
                      trailing: Text(viewModel.userData.postNum.toString()),
                      onTap: () => Navigator.pushNamed(
                          context, R.favoriteAttention,
                          arguments: [viewModel.userData, 0]),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(S.of(context).favoritePost),
                      trailing: Text(viewModel.userData.favoriteNum.toString()),
                      onTap: () => Navigator.pushNamed(
                          context, R.favoriteAttention,
                          arguments: [viewModel.userData, 1]),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(S.of(context).attention),
                      trailing:
                          Text(viewModel.userData.attentionNum.toString()),
                      onTap: () => Navigator.pushNamed(
                          context, R.favoriteAttention,
                          arguments: [viewModel.userData, 2]),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(S.of(context).follower),
                      trailing: Text(viewModel.userData.followerNum.toString()),
                      onTap: () => Navigator.pushNamed(
                          context, R.favoriteAttention,
                          arguments: [viewModel.userData, 3]),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(S.of(context).comment),
                      trailing: Text(viewModel.userData.commentNum.toString()),
                      onTap: () => Navigator.pushNamed(
                          context, R.favoriteAttention,
                          arguments: [viewModel.userData, 4]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _action(BuildContext context) {
    if (viewModel.uid == 0)
      return FlatButton(
        child: Text(S.of(context).login,
            style: TextStyle(color: Theme.of(context).accentColor)),
        onPressed: () => Navigator.of(context).pushNamed(R.login).then((_) {
          if (viewModel.uid == viewModel.userData.id)
            Navigator.of(context).pop();
          else
            viewModel.getAttention();
        }),
      );

    if (viewModel.attentionLoading == 2)
      return IconButton(
          onPressed: () => viewModel.getAttention(), icon: Icon(Icons.refresh));
    if (viewModel.attentionLoading == 1)
      return FlatButton(onPressed: null, child: CircularProgressIndicator());

    return FlatButton(
        child: Icon(
            viewModel.attention ? Icons.favorite : Icons.favorite_border,
            color: Theme.of(context).accentColor),
        onPressed: () => viewModel.changeAttention());
  }
}
