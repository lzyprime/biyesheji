import 'package:client/ui/post/other_user/other_user_widget.dart';
import 'package:client/ui/user/favorite_attention/favorite_attention_widget.dart';
import 'package:client/ui/user/settings/settings_widget.dart';
import 'package:flutter/material.dart';

import 'package:client/ui/home_widget.dart';
import 'package:client/ui/post/post_widget.dart';
import 'package:client/ui/login/login_widget.dart';
import 'package:client/ui/edit_post/edit_post_widget.dart';
import 'package:client/ui/edit_post/preview_post/preview_post_widget.dart';

class R {
  static const home = "/";
  static const login = "/login";
  static const editPost = "/edit_post";
  static const previewPost = "/preview_post";
  static const post = "/post";
  static const settings = "/settings";
  static const otherUser = "/other_user";
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
    case R.otherUser:
      widget = OtherUserWidget(settings.arguments);
      break;
    case R.favoriteAttention:
      widget = FavoriteAttentionWidget(settings.arguments);
      break;
    case R.settings:
      widget = SettingsWidget();
      break;
  }
  return MaterialPageRoute(builder: (_) => widget, settings: settings);
};

final String initialRoute = R.home;
