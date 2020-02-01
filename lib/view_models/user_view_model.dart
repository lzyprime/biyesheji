import 'package:client/globals/global.dart';
import 'package:flutter/material.dart';

import 'package:client/datas/user_data.dart';
import 'package:client/models/user_model.dart';

class UserViewModel with ChangeNotifier {
  final _userModel = UserModel();
  UserData userData;
  int uid;
  bool loading = false;

  bool get hadLogin => uid != 0;

  UserViewModel() {
    uid = Global.share.get(ShareKey.uid) ?? 0;
    getUserInfo();
  }

  getUserInfo() async {
    if (uid == 0) return;
    notifyListeners();

    _userModel.getUserInfo(uid).listen((res) {
      if (res.result == 0) {
        final newData = UserData.fromJson(res.data);
        if (newData.id == uid) {
          userData = newData;
        }
      }
      notifyListeners();
    });
  }

  logout() {
    Global.share.remove(ShareKey.uid);
    uid = 0;
    userData = null;
    notifyListeners();
  }
}
