import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:client/ui_module/post_list_card.dart';
import 'package:client/ui_module/comment_card.dart';
import 'package:client/ui_module/user_list_card.dart';
import 'package:client/datas/user_data.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/ui/user/dynamic/view_model.dart';

class DynamicWidget extends StatefulWidget {
  final DynamicViewModel viewModel;
  final int initialIndex;

  DynamicWidget(
    UserData userData, {
    this.initialIndex = 0,
  }) : viewModel = DynamicViewModel(userData);

  @override
  createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      child: DefaultTabController(
        initialIndex: widget.initialIndex,
        length: 5,
        child: Consumer<DynamicViewModel>(
            builder: (context, viewModel, __) => Scaffold(
                  appBar: AppBar(
                      title: Text(viewModel.userData.username),
                      centerTitle: true,
                      bottom: TabBar(
                        tabs: [
                          Tab(text: S.of(context).post),
                          Tab(text: S.of(context).favoritePost),
                          Tab(text: S.of(context).attention),
                          Tab(text: S.of(context).follower),
                          Tab(text: S.of(context).comment),
                        ],
                        isScrollable: true,
                      )),
                  body: SafeArea(
                    child: TabBarView(children: [
                      RefreshIndicator(
                        child: ListView.builder(
                          itemBuilder: (context, i) =>
                              PostListCard(viewModel.posts[i]),
                          itemCount: viewModel.posts.length,
                        ),
                        onRefresh: viewModel.refreshPosts,
                      ),
                      RefreshIndicator(
                        child: ListView.builder(
                          itemBuilder: (context, i) =>
                              PostListCard(viewModel.favorites[i]),
                          itemCount: viewModel.favorites.length,
                        ),
                        onRefresh: viewModel.refreshFavorites,
                      ),
                      RefreshIndicator(
                        child: ListView.builder(
                            itemBuilder: (context, i) =>
                                UserListCard(viewModel.attentions[i]),
                            itemCount: viewModel.attentions.length),
                        onRefresh: viewModel.refreshAttentions,
                      ),
                      RefreshIndicator(
                          child: ListView.builder(
                              itemBuilder: (context, i) =>
                                  UserListCard(viewModel.followers[i]),
                              itemCount: viewModel.followers.length),
                          onRefresh: viewModel.refreshFollowers),
                      RefreshIndicator(
                          child: ListView.builder(
                              itemBuilder: (context, i) => CommentCard(
                                    viewModel.comments[i],
                                    remove: () =>
                                        viewModel.removeComment(context, i),
                                  ),
                              itemCount: viewModel.comments.length),
                          onRefresh: viewModel.refreshComments),
                    ]),
                  ),
                )),
      ),
    );
  }
}
