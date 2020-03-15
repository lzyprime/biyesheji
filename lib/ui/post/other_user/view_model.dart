import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:client/models/favorite_model.dart';
import 'package:client/globals/cache.dart';
import 'package:client/datas/user_data.dart';

class OtherUserViewModel with ChangeNotifier {
  final UserData userData;

  OtherUserViewModel(this.userData) {
    getAttention();
  }

  final _model = FavoriteModel();

  int get uid => Cache().userData?.id ?? 0;

  bool attention = false;
  int attentionLoading = 0; // 0 normal, 1 loading, 2 failed
  getAttention() {
    if (uid == 0 || uid == userData.id) return;
    _model.attentionStatus(uid, userData.id).doOnListen(() {
      attentionLoading = 1;
      notifyListeners();
    }).listen((res) {
      attentionLoading = res.result == 0 ? 0 : 2;
      attention = res.data ?? false;
      notifyListeners();
    });
  }

  changeAttention() {
    if (uid == 0 || uid == userData.id) return;
    _model.changeAttention(uid, userData.id).doOnListen(() {
      attentionLoading = 1;
      notifyListeners();
    }).listen((res) {
      attentionLoading = 0;
      if (res.result == 0) attention = res.data;
      notifyListeners();
    });
  }
}
