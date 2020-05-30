import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'package:client/globals/cache.dart';
import 'package:client/datas/user_data.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/favorite_model.dart';

class UserViewModel with ChangeNotifier {
  static final Map<int, UserViewModel> _cache = {};
  UserData userData;

  factory UserViewModel(UserData userData) =>
      _cache[userData?.id ?? 0] ??= UserViewModel._(userData);

  UserViewModel._(this.userData) {
    if (uid != 0 && userData != null && userData.id != uid) getAttention();
  }

  final _model = UserModel();
  final _favoriteModel = FavoriteModel();

  int get uid => Cache().userData?.id ?? 0;

  Future<void> refresh() async {
    _model.getUserInfo(userData.id).listen((res) {
      if (res.result == 0) {
        userData = UserData.fromJson(res.data);
        if (userData.id == uid) Cache().updateUserData(userData);
        notifyListeners();
      }
    });
  }

  bool attention = false;
  int attentionLoading = 0; // 0 normal, 1 loading, 2 failed
  getAttention() {
    if (uid == 0 || uid == userData?.id) return;
    _favoriteModel.attentionStatus(uid, userData?.id).doOnListen(() {
      attentionLoading = 1;
      notifyListeners();
    }).listen((res) {
      attentionLoading = res.result == 0 ? 0 : 2;
      attention = res.data ?? false;
      notifyListeners();
    });
  }

  changeAttention() {
    if (uid == 0 || uid == userData?.id) return;
    _favoriteModel.changeAttention(uid, userData?.id).doOnListen(() {
      attentionLoading = 1;
      notifyListeners();
    }).listen((res) {
      attentionLoading = 0;
      if (res.result == 0) attention = res.data;
      notifyListeners();
    });
  }
}
