import 'package:client/ui/login/register/register_widget.dart';
import 'package:flutter/material.dart';

import 'package:client/ui/user/dynamic/dynamic_widget.dart';
import 'package:client/ui/user/settings/settings_widget.dart';
import 'package:client/ui/home_widget.dart';
import 'package:client/ui/post/post_widget.dart';
import 'package:client/ui/login/login_widget.dart';
import 'package:client/ui/edit_post/edit_post_widget.dart';
import 'package:client/ui/edit_post/preview_post/preview_post_widget.dart';
import 'package:client/ui/user/user_widget.dart';
class R {
  static const home = "/";
  static const login = "/login";
  static const register = "/register";
  static const editPost = "/edit_post";
  static const previewPost = "/preview_post";
  static const post = "/post";
  static const user = "/user";
  static const settings = "/settings";
  static const favoriteAttention = "/favorite_attention";
}

final RouteFactory onGenerateRoute = (RouteSettings settings) {
  Widget widget;
  switch (settings.name) {
    case R.home:
      widget = HomeWidget();
      break;
    case R.login:
      widget = LoginWidget();
      break;
    case R.editPost:
      widget = EditPostWidget(settings.arguments);
      break;
    case R.previewPost:
      widget = PreviewWidget(settings.arguments);
      break;
    case R.post:
      widget = PostWidget(settings.arguments);
      break;
    case R.user:
      widget = UserWidget(settings.arguments);
      break;
    case R.favoriteAttention:
      List args = settings.arguments;
      widget = DynamicWidget(args[0], initialIndex: args[1]);
      break;
    case R.settings:
      widget = SettingsWidget();
      break;
    case R.register:
      widget = RegisterWidget();
      break;
  }
  return MaterialPageRoute(builder: (_) => widget, settings: settings);
};

final String initialRoute = R.home;
