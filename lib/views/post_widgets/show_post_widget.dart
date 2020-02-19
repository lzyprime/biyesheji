import 'package:client/globals/route.dart';
import 'package:client/view_models/edit_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/view_models/show_post_view_model.dart';
import 'package:client/views/auth_widgets/need_login_dialog.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/views/post_widgets/post_column.dart';

class ShowPostWidget extends StatelessWidget {
  final ShowPostViewModel _viewModel;

  ShowPostWidget(this._viewModel);

  @override
  Widget build(BuildContext context) {
    final postData = _viewModel.postData;

    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<ShowPostViewModel>(
        builder: (_, _viewModel, __) => Material(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                actions: <Widget>[
                  _viewModel.isSelfPost
                      ? IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                                R.editPost,
                                arguments: EditPostViewModel(_viewModel.uid,
                                    postData: _viewModel.postData));
                          },
                        )
                      : IconButton(
                          icon: Icon(
                              _viewModel.favorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Theme.of(context).accentColor),
                          onPressed: () => _viewModel.uid == 0
                              ? LoginDialog(context)
                              : _viewModel.changeFavorite()),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(postData.title,
                          style: Theme.of(context).textTheme.display1),
                      FlatButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                              "${S.of(context).author}: ${postData.userData.username}"),
                          onPressed: _viewModel.isSelfPost ? null : () {}),
                      Text(
                          "${S.of(context).createTime}: ${postData.createTime}"),
                      Text(
                          "${S.of(context).updateTime}: ${postData.updateTime}"),
                    ],
                  ),
                ),
                floating: true,
                expandedHeight: 240,
              ),
              SliverToBoxAdapter(
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.8),
                  child: PostColumn(postData.title, postData.content),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
