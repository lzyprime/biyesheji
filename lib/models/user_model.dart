import 'dart:convert';

import 'package:client/datas/user_data.dart';
import 'package:client/globals/keys.dart';
import 'package:client/globals/net.dart';
import 'package:client/datas/result_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  static final _instance = UserModel._();

  UserModel._() {
    getUserInfo();
  }

  factory UserModel() => _instance;

  static const url = "/user";

  UserData userData;

  /// 登录
  Stream<ResultData> login(String username, String password) =>
      Net().get("$url/login", {
        "username": username,
        "password": password,
      });

  /// 注册
  Stream<ResultData> register(String username, String password, String email,
      int sex) =>
      Net().get("$url/register", {
        "username": username,
        "password": password,
        "email": email,
        "sex": sex,
      });

  /// 缓存用户信息
  saveUserInfo(UserData userData) {
    if (userData == null || userData.id == 0) return;
    this.userData = userData;
    SharedPreferences.getInstance()
        .then((v) => v.setString(K.userInfo, json.encode(userData)));
  }

  getUserInfo() {
    SharedPreferences.getInstance().then((v) =>
    userData = v.containsKey(K.userInfo)
        ? UserData.fromJson(json.decode(v.getString(K.userInfo)))
        : null);
  }

  /// 注销
  logout() {
    userData = null;
    SharedPreferences.getInstance().then((v) {
      v.remove(K.userInfo);
    });
  }
}
