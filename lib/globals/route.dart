import 'package:client/views/post_widgets/show_post_widget.dart';
import 'package:flutter/material.dart';

import 'package:client/views/auth_widgets/login_widget.dart';
import 'package:client/views/home_widgets/home_widget.dart';
import 'package:client/views/post_widgets/edit_post_widget.dart';
import 'package:client/views/post_widgets/preview_post_widget.dart';
import 'package:client/views/home_widgets/user_widgets/edit_user_info_widget.dart';

class R {
  static const home = "/";
  static const login = "/login";
  static const editPost = "/edit_post";
  static const editUerInfo = "/edit_user_info";
  static const previewPost = "/preview_post";
  static const post = "/post";
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
    case R.editUerInfo:
      widget = EditUserInfoWidget(settings.arguments);
      break;
    case R.previewPost:
      widget = PreviewPostWidget(settings.arguments);
      break;
    case R.post:
      widget = ShowPostWidget(settings.arguments);
      break;
  }
  return MaterialPageRoute(builder: (_) => widget, settings: settings);
};

final String initialRoute = R.home;
