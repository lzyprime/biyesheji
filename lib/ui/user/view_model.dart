import 'package:client/ui_module/input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/globals/cache.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/ui_module/enter_dialog.dart';
import 'package:client/datas/user_data.dart';
import 'package:client/models/user_model.dart';

class UserViewModel with ChangeNotifier {
  final _model = UserModel();

  UserData get userData => Cache().userData;

  Future<void> refresh() async {
    _model.getUserInfo(userData.id).listen((res) {
      if (res.result == 0) {
        Cache().updateUserData(UserData.fromJson(res.data));
        notifyListeners();
      }
    });
  }

  setAvatar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          InputDialog(title: S.of(context).avatar, initText: userData.avatar),
    ).then((v) {
      if (v != null && v != userData.avatar)
        _model.newAvatar(userData.id, v).listen((res) {
          if (res.result == 0) {
            userData.avatar = v;
            Cache.update(K.userInfo, userData);
            notifyListeners();
          } else
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(res.msg ?? "")));
        });
    });
  }

  logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => EnterDialog(S.of(context).logout)).then((v) {
      if (v == true) {
        Cache().clearUserData();
        notifyListeners();
      }
    });
  }
}
