import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/datas/comment_data.dart';
import 'package:client/models/comment_model.dart';

class CommentViewModel with ChangeNotifier {
  CommentViewModel(this.postId);

  final int postId;

  CommentViewModel._(this.postId) {
    refreshComments();
  }

  List<CommentData> comments = [];

  Future<void> refreshComments() async {
    CommentModel().getComments(postId).listen((res) {
      if (res.result == 0)
        comments =
            (res.data as List).map((i) => CommentData.fromJson(i)).toList();
      notifyListeners();
    });
  }

  newComment(BuildContext context, String content) {
    CommentModel().newComment(content, postId).listen((res) {
      if (res.result == 0)
        comments.add(CommentData.fromJson(res.data));
      else
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(res.msg)));
      notifyListeners();
    });
  }

  removeComment(BuildContext context, int index) {
    CommentModel().removeComment(comments[index].id).listen((res) {
      if (res.result == 0)
        comments.removeAt(index);
      else
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(res.msg)));
      notifyListeners();
    });
  }
}
