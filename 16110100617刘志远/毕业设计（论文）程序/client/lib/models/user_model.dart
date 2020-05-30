import 'package:client/globals/cache.dart';
import 'package:client/globals/net.dart';
import 'package:client/datas/result_data.dart';

class UserModel {
  static final _instance = UserModel._();

  factory UserModel() => _instance;

  UserModel._();

  static const url = "/user";

  String get get => "$url/get";

  String get set => "$url/set";

  String get auth => "$url/auth";

  /// 登录
  Stream<ResultData> login(String username, String password) =>
      Net().get("$auth/login", {
        "username": username,
        "password": password,
      });

  /// 注册
  Stream<ResultData> register(String username, String password, String email,
          int sex, String avatar) =>
      Net().get("$auth/register", {
        "username": username,
        "password": password,
        "email": email,
        "sex": sex,
        "avatar": avatar ?? "",
      });

  Stream<ResultData> getUserInfo(int uid) =>
      Net().get("$get/get_user_info", {"uid": uid});

  Stream<ResultData> posts(int uid) => Net().get("$get/posts", {"uid": uid});

  Stream<ResultData> favoritePosts(int uid) =>
      Net().get("$get/favorite_posts", {"uid": uid});

  Stream<ResultData> attentions(int uid) =>
      Net().get("$get/attentions", {"uid": uid});

  Stream<ResultData> followers(int uid) =>
      Net().get("$get/followers", {"uid": uid});

  Stream<ResultData> newUsername(String username) =>
      Net().get("$set/new_username", {
        "uid": Cache().userData.id,
        "username": username,
        "auth": Cache().authCode ?? "",
      });

  Stream<ResultData> newAvatar(String avatarUrl) =>
      Net().get("$set/new_avatar", {
        "uid": Cache().userData.id,
        "avatar": avatarUrl,
        "auth": Cache().authCode ?? "",
      });

  Stream<ResultData> newPassword(String newPassword) =>
      Net().get("$set/new_password", {
        "uid": Cache().userData.id,
        "newPassword": newPassword,
        "auth": Cache().authCode ?? "",
      });

  Stream<ResultData> newSex(int uid, int sex) => Net().get("$set/new_sex", {
        "uid": Cache().userData.id,
        "sex": sex,
        "auth": Cache().authCode ?? "",
      });
}
