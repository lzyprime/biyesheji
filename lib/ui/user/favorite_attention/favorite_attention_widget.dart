import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/localizations.dart';
import 'package:client/globals/route.dart';
import 'package:client/ui/user/favorite_attention/view_model.dart';

class FavoriteAttentionWidget extends StatefulWidget {
  final initialIndex;

  FavoriteAttentionWidget(this.initialIndex);

  @override
  createState() => _FavoriteAttentionWidgetState();
}

class _FavoriteAttentionWidgetState extends State<FavoriteAttentionWidget> {
  @override
  void initState() {
    super.initState();
    final viewModel = FavoriteAttentionViewModel();
    viewModel.refreshPosts();
    viewModel.refreshFavorites();
    viewModel.refreshAttentions();
    viewModel.refreshFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: FavoriteAttentionViewModel(),
      child: DefaultTabController(
        initialIndex: widget.initialIndex,
        length: 4,
        child: Consumer<FavoriteAttentionViewModel>(
            builder: (context, viewModel, __) => Scaffold(
                  appBar: AppBar(
                      bottom: TabBar(
                    tabs: [
                      Tab(text: S.of(context).post),
                      Tab(text: S.of(context).favoritePost),
                      Tab(text: S.of(context).attention),
                      Tab(text: S.of(context).follower),
                    ],
                  )),
                  body: SafeArea(
                    child: TabBarView(children: [
                      RefreshIndicator(
                          child: ListView.separated(
                            itemBuilder: (context, i) => ListTile(
                              onTap: () => Navigator.pushNamed(context, R.post,
                                      arguments: viewModel.posts[i])
                                  .then((_) => viewModel.refreshPosts()),
                              title: Text(viewModel.posts[i].title),
                              trailing:
                                  Text("${viewModel.posts[i].updateTime}"),
                            ),
                            separatorBuilder: (_, __) =>
                                Divider(height: 4, thickness: 2),
                            itemCount: viewModel.posts.length,
                          ),
                          onRefresh: viewModel.refreshPosts),
                      RefreshIndicator(
                          child: ListView.separated(
                            itemBuilder: (context, i) => ListTile(
                              isThreeLine: true,
                              onTap: () => Navigator.pushNamed(context, R.post,
                                      arguments: viewModel.favorites[i])
                                  .then((_) => viewModel.refreshFollowers()),
                              title: Text(viewModel.favorites[i].title),
                              subtitle: Text(
                                  "${S.of(context).author}: ${viewModel.favorites[i].userData.username}"),
                              trailing:
                                  Text("${viewModel.favorites[i].updateTime}"),
                            ),
                            separatorBuilder: (context, i) =>
                                Divider(height: 4, thickness: 2),
                            itemCount: viewModel.favorites.length,
                          ),
                          onRefresh: viewModel.refreshFavorites),
                      RefreshIndicator(
                          child: ListView.builder(
                              itemBuilder: (context, i) => Card(
                                    child: ListTile(
                                      leading: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(width: 0.5)),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                                viewModel
                                                    .attentions[i].avatar)),
                                      ),
                                      title: Text(
                                          viewModel.attentions[i].username),
                                      subtitle:
                                          Text(viewModel.attentions[i].sexStr),
                                      onTap: () => Navigator.of(context)
                                          .pushNamed(R.otherUser,
                                              arguments:
                                                  viewModel.attentions[i])
                                          .then((_) =>
                                              viewModel.refreshAttentions()),
                                    ),
                                  ),
                              itemCount: viewModel.attentions.length),
                          onRefresh: viewModel.refreshAttentions),
                      RefreshIndicator(
                          child: ListView.builder(
                              itemBuilder: (context, i) => Card(
                                    child: ListTile(
                                      leading: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(width: 0.5)),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                                viewModel.followers[i].avatar)),
                                      ),
                                      title:
                                          Text(viewModel.followers[i].username),
                                      subtitle:
                                          Text(viewModel.followers[i].sexStr),
                                      onTap: () => Navigator.of(context)
                                          .pushNamed(R.otherUser,
                                              arguments: viewModel.followers[i])
                                          .then((_) =>
                                              viewModel.refreshFollowers()),
                                    ),
                                  ),
                              itemCount: viewModel.followers.length),
                          onRefresh: viewModel.refreshFollowers),
                    ]),
                  ),
                )),
      ),
    );
  }
}
