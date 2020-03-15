import 'package:flutter/material.dart';

import 'package:client/datas/post_data.dart';
import 'package:client/datas/user_data.dart';
import 'package:client/models/user_model.dart';
import 'package:client/globals/cache.dart';

class FavoriteAttentionViewModel with ChangeNotifier {
  static final _instance = FavoriteAttentionViewModel._();

  factory FavoriteAttentionViewModel() => _instance;

  FavoriteAttentionViewModel._() {
    refreshPosts();
    refreshFavorites();
    refreshAttentions();
    refreshFollowers();
  }

  final _model = UserModel();

  UserData get userData => Cache().userData;
  List<PostData> posts = [];
  List<PostData> favorites = [];
  List<UserData> attentions = [];
  List<UserData> followers = [];

  Future<void> refreshPosts() async {
    if (userData == null || userData.id == 0) return;
    _model.posts(userData.id).listen((res) {
      if (res.result == 0)
        posts = (res.data as List).map((i) => PostData.fromJson(i)).toList();
      notifyListeners();
    });
  }

  Future<void> refreshFavorites() async {
    if (userData == null || userData.id == 0) return;
    _model.favoritePosts(userData.id).listen((res) {
      if (res.result == 0)
        favorites =
            (res.data as List).map((i) => PostData.fromJson(i)).toList()..sort((a,b) => b.compareTo(a));
      notifyListeners();
    });
  }

  Future<void> refreshAttentions() async {
    if (userData == null || userData.id == 0) return;
    _model.attentions(userData.id).listen((res) {
      if (res.result == 0)
        attentions =
            (res.data as List).map((i) => UserData.fromJson(i)).toList();
      notifyListeners();
    });
  }

  Future<void> refreshFollowers() async {
    if (userData == null || userData.id == 0) return;
    _model.followers(userData.id).listen((res) {
      if (res.result == 0)
        followers =
            (res.data as List).map((i) => UserData.fromJson(i)).toList();
      notifyListeners();
    });
  }
}
