import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client/views/home_widgets/home_widget.dart';
import 'package:client/views/auth_widget.dart';

class Global {
  /// route
  final routes = {
    HomeWidget.routeName: (_) => HomeWidget(),
    AuthWidget.routeName: (_) => AuthWidget(),
  };

  /// theme

  get theme => ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        accentColor: Colors.pink,
      );

  /// save
  static SharedPreferences share;

  static Future init() async {
    share = await SharedPreferences.getInstance();
  }
}

class ShareKey {
  static const theme = 'theme';

  static const userId = 'user_id';
}

class GlobalColor {
  static final goldColor = Color.fromRGBO(255, 215, 0, 1);
}
