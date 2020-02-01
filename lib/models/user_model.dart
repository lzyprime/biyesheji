import 'package:client/globals/net.dart';
import 'package:client/datas/result_data.dart';

class UserModel {
  static const _instance = UserModel._();

  const UserModel._();

  factory UserModel() => _instance;

  static const url = "/user";

  /// 登录
  Stream<ResultData> login(username, password) => Net().get("$url/login", {
        "username": username,
        "password": password,
      });

  /// 注册
  Stream<ResultData> register(
          String username, String password, String email, int sex) =>
      Net().get("$url/register", {
        "username": username,
        "password": password,
        "email": email,
        "sex": sex,
      });

  Stream<ResultData> getUserInfo(int uid) =>
    Net().get("$url/get_user_info", {
      "uid": uid,
    });

}
