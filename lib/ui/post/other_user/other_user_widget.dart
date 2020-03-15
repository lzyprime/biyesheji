import 'package:flutter/material.dart';

import 'package:client/globals/route.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/ui/post/other_user/view_model.dart';
import 'package:client/datas/user_data.dart';
import 'package:provider/provider.dart';

class OtherUserWidget extends StatelessWidget {
  final OtherUserViewModel viewModel;

  OtherUserWidget(UserData data) : viewModel = OtherUserViewModel(data);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            Consumer<OtherUserViewModel>(
              builder: (context, viewModel, __) => SliverAppBar(
                actions: <Widget>[_action(context)],
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
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
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                expandedHeight: 400,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _action(BuildContext context) {
    if (viewModel.uid == 0)
      return FlatButton(
        child: Text(S.of(context).login, style: TextStyle(color: Colors.white)),
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
