import 'package:client/globals/global.dart';
import 'package:flutter/material.dart';
import 'package:client/globals/i18n.dart';

import 'package:client/datas/user_data.dart';
import 'package:client/models/user_model.dart';

class AuthViewModel with ChangeNotifier {
  BuildContext context;

  AuthViewModel([this.context]);

  final _model = UserModel();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final emailController = TextEditingController();
  EnumSex sex = EnumSex.obscure;

  setSex(v) {
    sex = v;
    notifyListeners();
  }

  bool isRegister = false;

  changeRegister() {
    isRegister = !isRegister;
    notifyListeners();
  }

  bool showPassword = false;

  changeShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  String errorText;
  bool loading = false;

  login() {
    errorText = null;
    if (loading) return;

    final username = usernameController.text;
    final password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      errorText = S.of(context).notNull;
      notifyListeners();
      return;
    }
    loading = true;
    notifyListeners();
    _model.login(username, password).listen((res) {
      loading = false;
      if (res.result != 0) {
        errorText = res.msg;
        notifyListeners();
      } else {
        Global.share.setInt(ShareKey.uid, res.data);
        Navigator.of(context).pop(res.data);
      }
    });
  }

  register() {
    errorText = null;
    if (loading) return;

    final username = usernameController.text;
    final password = passwordController.text;
    final rePassword = rePasswordController.text;
    final email = emailController.text;

    if (username.isEmpty ||
        password.isEmpty ||
        rePassword.isEmpty ||
        email.isEmpty) {
      errorText = S.of(context).notNull;
      notifyListeners();
      return;
    }

    if(password != rePassword){
      errorText = '${S.of(context).password}${S.of(context).inconsistent}';
      notifyListeners();
      return;
    }

    loading = true;
    notifyListeners();
    _model.register(username, password, email, sex.index).listen((res){
      loading = false;
      if(res.result != 0){
        errorText = res.msg;
        notifyListeners();
      }else {
        Global.share.setInt(ShareKey.uid, res.data);
        Navigator.of(context).pop(res.data);
      }
    });
  }
}
