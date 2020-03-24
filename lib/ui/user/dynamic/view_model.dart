import 'package:flutter/material.dart';

import 'package:client/datas/comment_data.dart';
import 'package:client/models/comment_model.dart';
import 'package:client/datas/post_data.dart';
import 'package:client/datas/user_data.dart';
import 'package:client/models/user_model.dart';

class DynamicViewModel with ChangeNotifier {
  static final Map<int, DynamicViewModel> _cache = {};

  factory DynamicViewModel(UserData userData) =>
      _cache[userData.id] ??= DynamicViewModel._(userData);

  DynamicViewModel._(this.userData) {
    refreshPosts();
    refreshFavorites();
    refreshAttentions();
    refreshFollowers();
    refreshComments();
  }

  final UserData userData;

  final _model = UserModel();

  List<PostData> posts = [];
  List<PostData> favorites = [];
  List<UserData> attentions = [];
  List<UserData> followers = [];
  List<CommentData> comments = [];

  Future<void> refreshPosts() async {
    if (userData == null || userData.id == 0) return;
    _model.posts(userData.id).listen((res) {
      if (res.result == 0)
        posts
          ..clear()
          ..addAll((res.data as List).map((i) => PostData.fromJson(i)));
      notifyListeners();
    });
  }

  Future<void> refreshFavorites() async {
    if (userData == null || userData.id == 0) return;
    _model.favoritePosts(userData.id).listen((res) {
      if (res.result == 0)
        favorites
          ..clear()
          ..addAll((res.data as List).map((i) => PostData.fromJson(i)))
          ..sort((a, b) => b.compareTo(a));
      notifyListeners();
    });
  }

  Future<void> refreshAttentions() async {
    if (userData == null || userData.id == 0) return;
    _model.attentions(userData.id).listen((res) {
      if (res.result == 0)
        attentions
          ..clear()
          ..addAll((res.data as List).map((i) => UserData.fromJson(i)));
      notifyListeners();
    });
  }

  Future<void> refreshFollowers() async {
    if (userData == null || userData.id == 0) return;
    _model.followers(userData.id).listen((res) {
      if (res.result == 0)
        followers
          ..clear()
          ..addAll((res.data as List).map((i) => UserData.fromJson(i)));
      notifyListeners();
    });
  }

  Future<void> refreshComments() async {
    CommentModel().getUserComments(userData.id).listen((res) {
      if (res.result == 0)
        comments =
            (res.data as List).map((i) => CommentData.fromJson(i)).toList();
      notifyListeners();
    });
  }

  removeComment(BuildContext context, int index) {
    CommentModel().removeComment(comments[index].id).listen((res) {
      if (res.result == 0) comments.removeAt(index);
      else
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(res.msg)));
      notifyListeners();
    });
  }
}
