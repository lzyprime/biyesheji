import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:client/datas/user_data.dart';
import 'package:client/models/user_model.dart';

class LoginViewModel with ChangeNotifier {
  final _model = UserModel();

  String username = "";
  String password = "";

  bool get enableLogin => username.isNotEmpty && password.isNotEmpty;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool v) {
    _loading = v;
    notifyListeners();
  }

  String _errorText;

  String get errorText => _errorText;

  set errorText(String v) {
    _errorText = v;
    notifyListeners();
  }

  login(BuildContext context) {
    errorText = null;
    _model
        .login(username, password)
        .doOnListen(() => loading = true)
        .doOnDone(() => loading = false)
        .doOnData((res) {
      if (res.result != 0 || res.data == 0) {
        errorText = res.msg;
        return;
      } else {
        final userData = UserData.fromJson(res.data);
        if (userData.id == 0) return;
        _model.saveUserInfo(userData);
        Navigator.of(context).pop(userData);
      }
    }).listen(null);
  }
}
