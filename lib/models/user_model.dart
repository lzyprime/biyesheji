import 'package:client/globals/net.dart';
import 'package:client/datas/result_data.dart';

class UserModel {
  static final _instance = UserModel._();

  factory UserModel() => _instance;

  UserModel._();

  static const url = "/user";

  /// 登录
  Stream<ResultData> login(String username, String password) =>
      Net().get("$url/login", {
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
      Net().get("$url/get_user_info", {"uid": uid});

  Stream<ResultData> posts(int uid) => Net().get("$url/posts", {"uid": uid});

  Stream<ResultData> favoritePosts(int uid) =>
      Net().get("$url/favorite_posts", {"uid": uid});

  Stream<ResultData> attentions(int uid) =>
      Net().get("$url/attentions", {"uid": uid});

  Stream<ResultData> followers(int uid) =>
      Net().get("$url/followers", {"uid": uid});

  Stream<ResultData> newUsername(int uid, String username) =>
      Net().get("$url/new_username", {
        "uid": uid,
        "username": username,
      });

  Stream<ResultData> newAvatar(int uid, String avatarUrl) =>
      Net().get("$url/new_avatar", {
        "uid": uid,
        "avatar": avatarUrl,
      });

  Stream<ResultData> newPassword(
          int uid, String oldPassword, String newPassword) =>
      Net().get("$url/new_password", {
        "uid": uid,
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      });

  Stream<ResultData> newSex(int uid, int sex) => Net().get("$url/new_sex", {
        "uid": uid,
        "sex": sex,
      });
}
