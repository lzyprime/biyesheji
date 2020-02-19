import 'package:client/view_models/show_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/route.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/view_models/edit_post_view_model.dart';
import 'package:client/view_models/user_view_model.dart';
import 'package:client/view_models/post_list_view_model.dart';

class PostListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PostListViewModel viewModel = Provider.of(context);
    final uid = Provider.of<UserViewModel>(context)?.userData?.id ?? 0;

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).news),
        ),
        body: RefreshIndicator(
            child: ListView.builder(
                itemBuilder: (_, i) => Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(R.post,
                              arguments: ShowPostViewModel(viewModel.data[i]));
                        },
                        title: Text(viewModel.data[i].title),
                        subtitle: Text(
                            "${S.of(context).author}: ${viewModel.data[i].userData.username}"),
                        trailing: Column(children: <Widget>[
                          Text("${S.of(context).updateTime}:"),
                          Text(viewModel.data[i].updateTime),
                        ]),
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                itemCount: viewModel.data.length),
            onRefresh: viewModel.refresh));
  }
}
