import 'dart:ui';
import 'package:client/globals/cache.dart';
import 'package:client/globals/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/localizations.dart';
import 'package:client/ui_module/comment_card.dart';
import 'package:client/ui/post/comment/view_model.dart';

class CommentWidget extends StatefulWidget {
  final CommentViewModel viewModel;

  CommentWidget(int postId) : viewModel = CommentViewModel(postId);

  @override
  createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final contentController = TextEditingController();
  String error;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white60),
                      onPressed: () => Navigator.of(context).pop()),
                ),
              ),
              ChangeNotifierProvider.value(
                value: widget.viewModel,
                child: Consumer<CommentViewModel>(
                  builder: (context, viewModel, __) => Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: RefreshIndicator(
                            onRefresh: viewModel.refreshComments,
                            child: ListView.builder(
                                itemBuilder: (context, i) => CommentCard(
                                    viewModel.comments[i],
                                    remove: () =>
                                        viewModel.removeComment(context, i)),
                                itemCount: viewModel.comments.length),
                          )),
                          Card(
                              child: ListTile(
                            title: TextField(
                              controller: contentController,
                              decoration: InputDecoration(
                                labelText: S.of(context).comment,
                                errorText: error,
                              ),
                              minLines: 1,
                              maxLines: 4,
                              maxLength: 100,
                              onChanged: (_) => setState(() {}),
                            ),
                            trailing: RaisedButton(
                                onPressed: contentController.text.isEmpty
                                    ? null
                                    : () {
                                        if (Cache().userData == null) {
                                          Navigator.of(context)
                                              .pushNamed(R.login);
                                          return;
                                        }
                                        viewModel.newComment(
                                            context, contentController.text);

                                        setState(() {
                                          contentController.text = "";
                                        });
                                      },
                                child: Icon(Icons.done)),
                          )),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
