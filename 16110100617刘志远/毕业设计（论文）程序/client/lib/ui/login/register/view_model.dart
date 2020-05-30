import 'package:client/datas/user_data.dart';
import 'package:client/globals/cache.dart';
import 'package:client/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:client/globals/localizations.dart';
import 'package:client/ui_module/input_dialog.dart';

class RegisterViewModel with ChangeNotifier {
  String avatar;
  String username;
  String password;
  String rePassword;
  String email;
  String errorText = "";
  EnumSex sex = EnumSex.obscure;
  bool loading = false;

  bool get allDone =>
      (username?.isNotEmpty ?? false) &&
      (password?.isNotEmpty ?? false) &&
      (rePassword?.isNotEmpty ?? false) &&
      (email?.isNotEmpty ?? false);

  setAvatar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          InputDialog(title: S.of(context).avatar, initText: avatar ?? ""),
    ).then((v) {
      if (v == null) return;
      if (v == "")
        avatar = null;
      else
        avatar = v;
      notifyListeners();
    });
  }

  register(BuildContext context) {
    if (password != rePassword) {
      errorText = "${S.current.password}${S.current.inconsistent}";
      notifyListeners();
      return;
    }

    errorText = "";

    UserModel()
        .register(username, password, email, sex.index, avatar)
        .doOnListen(() {
      loading = true;
      notifyListeners();
    }).doOnDone(() {
      loading = false;
      notifyListeners();
    }).doOnData((res) {
      if (res.result == 0) {
        Cache().updateUserData(UserData.fromJson(res.data["user"]));
        Cache().updateAuthCode(res.data["authCode"]);
        Navigator.of(context).pop(true);
      }
      else
        errorText = res.msg;
    }).listen(null);
  }
}
