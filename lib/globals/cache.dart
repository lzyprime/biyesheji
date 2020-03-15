import 'dart:convert';

import 'package:client/datas/post_data.dart';
import 'package:client/datas/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static final _instance = Cache._();

  factory Cache() => _instance;

  factory Cache.update(String type, dynamic data) {
    _instance.update(type, data);
    return _instance;
  }

  Cache._();

  static SharedPreferences shared;

  /// user data
  UserData _userData;

  UserData get userData => _userData;

  void updateUserData(UserData userData) {
    if (userData == null || userData.id <= 0) return;

    _userData = userData;
    shared.setString(K.userInfo, json.encode(userData.toJson()));
  }

  void clearUserData() {
    _userData = null;
    shared.remove(K.userInfo);
  }

  /// posts
  Map<int, PostData> posts = {};

  updatePosts(List<PostData> newPosts) async {
    if (newPosts == null) return;
    newPosts.forEach((i) => posts[i.id] = i);
    await shared.setStringList(
        K.posts, posts.values.map((i) => json.encode(i.toJson())).toList());
  }

  /// latest news
  List<int> _latestNews = [];

  List<PostData> get latestNews =>
      _latestNews.map((i) => posts[i]).toList()..sort((a, b) => b.compareTo(a));

  Future<bool> updateLatestNews(List<PostData> latestNews) async {
    if (latestNews == null) return false;
    if (await updatePosts(latestNews) == false) return false;
    _latestNews = latestNews.map((i) => i.id).toList();
    return await shared.setStringList(
        K.latestNews, _latestNews.map((i) => i.toString()).toList());
  }

  cleanLatestNews() {
    _latestNews.clear();
    shared.remove(K.latestNews);
  }

  /// manager
  Future loadCache() async {
    shared = await SharedPreferences.getInstance();

    if (shared.containsKey(K.userInfo))
      _userData = UserData.fromJson(json.decode(shared.getString(K.userInfo)));

    posts.clear();
    if (shared.containsKey(K.posts))
      shared
          .getStringList(K.posts)
          .map((i) => PostData.fromJson(json.decode(i)))
          .forEach((i) => posts[i.id] = i);

    if (shared.containsKey(K.latestNews))
      _latestNews = shared
          .getStringList(K.latestNews)
          .map((item) => int.parse(item))
          .toList();
  }

  update(String type, dynamic data) {
    if (type == K.userInfo)
      updateUserData(data);
    else if (type == K.posts)
      updatePosts(data);
    else if (type == K.latestNews) updateLatestNews(data);
  }
}

class K {
  static const userInfo = "user_info";
  static const posts = "posts";
  static const latestNews = "latest_news";
}
