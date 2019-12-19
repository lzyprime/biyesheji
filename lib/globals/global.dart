import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client/views/home_widgets/home_widget.dart';
import 'package:client/views/auth_widget.dart';
import 'package:client/views/edit_user_info_widget.dart';

class Global {
  /// route
  final routes = {
    HomeWidget.routeName: (_) => HomeWidget(),
    AuthWidget.routeName: (_) => AuthWidget(),
    EditUserInfoWidget.routeName: (_) => EditUserInfoWidget(),
  };

  /// theme

  get theme => ThemeData(primarySwatch: Colors.purple);

  /// save
  static SharedPreferences share;

  static Future init() async {
    share = await SharedPreferences.getInstance();
  }
}

class ShareKey {
  static const theme = "theme";
}
