import 'package:client/views/home_widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/models/user_model.dart';

enum AuthStateType { normal, loading, done }

class AuthViewModel with ChangeNotifier {
  final _model = UserModel();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final enterPasswordController = TextEditingController();
  final emailController = TextEditingController();

  int gender = 0;

  String get username => usernameController.text;

  String get password => passwordController.text;

  String get enterPassword => enterPasswordController.text;

  String get email => emailController.text;

  String usernameError;
  String passwordError;
  String enterPasswordError;
  String emailError;
  String loginError;
  String registerError;

  AuthStateType loginState = AuthStateType.normal;
  AuthStateType registerState = AuthStateType.normal;

  _resetError() {
    usernameError = null;
    passwordError = null;
    enterPasswordError = null;
    emailError = null;
    loginError = null;
    registerError = null;
  }

  bool _verifyUserName() {
    if (username?.isEmpty ?? true) {
      usernameError = S.current.notNull;
      return false;
    }
    return true;
  }

  bool _verifyPassword() {
    if (password?.isEmpty ?? true) {
      passwordError = S.current.notNull;
      return false;
    }
    return true;
  }

  bool _verifyEnterPassWord() {
    if ((password?.isEmpty ?? true) || (enterPassword?.isEmpty ?? true) || (password != enterPassword)) {
      enterPasswordError = '${S.current.password}${S.current.inconsistent}';
      return false;
    }
    return true;
  }

  bool _verifyEmail() {
    if (email?.isEmpty ?? true) {
      emailError = S.current.notNull;
      return false;
    }
    return true;
  }

  AuthViewModel() {
    usernameController.addListener(() {
      _resetError();
      notifyListeners();
    });
    passwordController.addListener(() {
      _resetError();
      _verifyUserName();
      notifyListeners();
    });
    enterPasswordController.addListener(() {
      _resetError();
      _verifyUserName();
      _verifyPassword();
      notifyListeners();
    });
    emailController.addListener(() {
      _resetError();
      _verifyUserName();
      _verifyPassword();
      _verifyEnterPassWord();
      notifyListeners();
    });
  }

  setGender(int v) {
    gender = v;
    _resetError();
    _verifyUserName();
    _verifyPassword();
    _verifyEnterPassWord();
    _verifyEmail();
    notifyListeners();
  }

  login(BuildContext context) {
    bool verify = _verifyUserName() && _verifyPassword();
    notifyListeners();
    if (!verify) return;
    _model.login(username, password).doOnListen(() {
      loginState = AuthStateType.loading;
      notifyListeners();
    }).listen((res) {
      if (res.result) {
        loginState = AuthStateType.done;
        notifyListeners();
        Future.delayed(Duration(seconds: 1), () => Navigator.of(context).pushReplacementNamed(HomeWidget.routeName));
      } else {
        loginError = res.msg;
        loginState = AuthStateType.normal;
        notifyListeners();
      }
    });
  }

  void register(context) {
    _model.register(username, password, email, gender).doOnListen(() {
      registerState = AuthStateType.loading;
      notifyListeners();
    }).listen((res) {
      if (res.result) {
        registerState = AuthStateType.done;
        notifyListeners();
        Future.delayed(Duration(seconds: 1), () => Navigator.of(context).pushReplacementNamed(HomeWidget.routeName));
      } else {
        registerError = res.msg;
        registerState = AuthStateType.normal;
        notifyListeners();
      }
    });
  }
}
