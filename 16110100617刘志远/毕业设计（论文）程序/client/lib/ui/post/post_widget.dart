import 'package:client/ui/post/comment/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/route.dart';
import 'package:client/datas/post_data.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/ui/post/view_model.dart';
import 'package:client/ui_module/post_content_card.dart';

class PostWidget extends StatefulWidget {
  final PostViewModel viewModel;

  PostWidget(PostData data) : viewModel = PostViewModel(data);

  @override
  createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    final postData = widget.viewModel.postData;

    return ChangeNotifierProvider.value(
        value: widget.viewModel,
        child: Consumer<PostViewModel>(
          builder: (context, viewModel, ___) => Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  actions: [_action(context), _remove(context)],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            postData.title,
                            style: Theme.of(context).textTheme.display1,
                            textAlign: TextAlign.center,
                          ),
                          FlatButton(
                              color: Theme.of(context).accentColor,
                              child: Text(
                                  "${S.of(context).author}: ${postData.userData.username}"),
                              onPressed: viewModel.isSelfPost
                                  ? null
                                  : () => Navigator.pushNamed(context, R.user,
                                      arguments: postData.userData)),
                          Text(
                              "${S.of(context).createTime}: ${postData.createTime}"),
                          Text(
                              "${S.of(context).updateTime}: ${postData.updateTime}"),
                        ],
                      ),
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 400,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.8),
                    child: PostContentCard(postData.title, postData.content),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => CommentWidget(postData.id)),
              child: Icon(Icons.comment),
            ),
          ),
        ));
  }

  Widget _action(BuildContext context) {
    final PostViewModel viewModel = Provider.of(context);
    if (viewModel.isSelfPost)
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context)
              .pushReplacementNamed(R.editPost, arguments: viewModel.postData);
        },
      );
    if (viewModel.uid == 0)
      return FlatButton(
        child: Text(S.of(context).login, style: TextStyle(color: Colors.white)),
        onPressed: () => Navigator.of(context)
            .pushNamed(R.login)
            .then((_) => viewModel.getFavorite()),
      );

    if (viewModel.favoriteLoading == 2)
      return IconButton(
          onPressed: () => viewModel.getFavorite(), icon: Icon(Icons.refresh));
    if (viewModel.favoriteLoading == 1)
      return FlatButton(onPressed: null, child: CircularProgressIndicator());

    return FlatButton(
        child: Icon(viewModel.favorite ? Icons.favorite : Icons.favorite_border,
            color: Theme.of(context).accentColor),
        onPressed: () => viewModel.changeFavorite());
  }

  Widget _remove(BuildContext context) {
    final PostViewModel viewModel = Provider.of(context);
    if (viewModel.postData.userData.id == viewModel.uid)
      return IconButton(
          onPressed: () => viewModel.removePost(context),
          icon: Icon(Icons.delete));
    return Container();
  }
}
