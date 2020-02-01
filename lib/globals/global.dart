import 'package:client/views/user_widgets/edit_user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client/views/home_widgets/home_widget.dart';
import 'package:client/views/auth_widgets/auth_widget.dart';

class Global {
  /// route
  final routes = {
    HomeWidget.routeName: (_) => HomeWidget(),
    AuthWidget.routeName: AuthWidget.routeBuilder,
    EditUserInfoWidget.routeName: (_) => EditUserInfoWidget(),
  };

  /// theme

  get theme => ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        accentColor: Colors.pink,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.purple,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textTheme: ButtonTextTheme.primary,
        ),
      );

  /// save
  static SharedPreferences share;

  static Future init() async {
    share = await SharedPreferences.getInstance();
  }
}

class ShareKey {
  static const theme = 'theme';

  static const uid = 'uid';

  static const userInfo = "userInfo";
}
