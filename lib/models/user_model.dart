import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/globals/net.dart';

class UserModel with Net {
  static const url = '/user';


  /// 登录
  Observable login(username, password) => Observable.fromFuture(
        dio.get('$url/login', queryParameters: {
          'username': username,
          'password': password,
        }),
      );

  /// 注册
  register(String username, String password, String email, int gender) => Observable.fromFuture(
        dio.get('$url/register', queryParameters: {
          'username': username,
          'password': password,
          'email': email,
          'gender': gender,
        }),
      );

  Observable getUserInfo() => Observable.fromFuture(
        Future.delayed(
            Duration(seconds: 1),
            () => <String, dynamic>{
                  "user_id": 111,
                  "username": "prime",
                  "password": "",
                  "email": "www@qq.com",
                  "sex": 1,
                  "phone": "18678311419",
                  "avatar":
                      "https://upload.jianshu.io/users/upload_avatars/1630262/c714156b-9415-4b8f-ae97-ae058c6b8a98.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"
                }),
      );
}
