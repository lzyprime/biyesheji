import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter_localizations/flutter_localizations.dart';

class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const delegate = _CustomLocalizationsDelegate();

  static const localizationsDelegates = [
    delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];

  static const supportedLocales = <Locale>[
    Locale("zh", "CN"),
    Locale("en", "US"),
  ];

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get login => "登录";

  String get register => "注册";

  String get username => "用户名";

  String get password => "密码";

  String get rePassword => "确认密码";

  String get email => "邮箱";

  String get obscure => "保密";

  String get male => "男";

  String get female => "女";

  String get notNull => "不能为空!";

  String get inconsistent => "不一致";

  String get reloading => "重新加载";

  String get netError => "网络请求失败";

  String get logout => "退出登录";

  String get preview => "预览";

  String get post => "文章";

  String get postContent => "文章内容 (markdown)";

  String get postTitle => "文章标题";

  String get news => "最新动态";

  String get author => "作者";

  String get createTime => "创建于";

  String get updateTime => "更新于";

  String get favoritePost => "收藏文章";

  String get attention => "关注用户";

  String get follower => "粉丝";

  String get editUserInfo => "编辑用户信息";

  String get language => "语言";

  String get theme => "主题";

  String get avatar => "头像";

  String get comment => "评论";

  String get gender => "性别";

  String get followSystem => "跟随系统";

  String get darkTheme => "深色主题";

  String get light => "亮色";

  String get dark => "暗色";
}

class $zhCN extends S {
  const $zhCN();
}

class $enUS extends S {
  const $enUS();

  @override
  String get attention => "attention";

  @override
  String get author => "author";

  @override
  String get avatar => "avatar";

  @override
  String get comment => "comment";

  @override
  String get createTime => "create time";

  @override
  String get editUserInfo => "edit userInfo";

  @override
  String get email => "email";

  @override
  String get favoritePost => "favorite post";

  @override
  String get female => "female";

  @override
  String get follower => "follower";

  @override
  String get gender => "gender";

  @override
  String get inconsistent => "inconsistent";

  @override
  String get language => "language";

  @override
  String get login => "login";

  @override
  String get logout => "logout";

  @override
  String get male => "male";

  @override
  String get netError => "Connection failed";

  @override
  String get news => "News";

  @override
  String get notNull => "Can not be empty";

  @override
  String get obscure => "invisible";

  @override
  String get password => "password";

  @override
  String get post => "post";

  @override
  String get postContent => "post content (markdown)";

  @override
  String get postTitle => "post title";

  @override
  String get preview => "preview";

  @override
  String get rePassword => "confirm password";

  @override
  String get register => "register";

  @override
  String get reloading => "reloading";

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get theme => "theme";

  @override
  String get updateTime => "update time";

  @override
  String get username => "username";

  @override
  String get followSystem => "follow system";

  @override
  String get darkTheme => "dark Theme";

  @override
  String get light => "light";

  @override
  String get dark => "dark";
}

class _CustomLocalizationsDelegate extends LocalizationsDelegate<S> {
  const _CustomLocalizationsDelegate();

  @override
  Future<S> load(Locale locale) {
    if (locale != null) {
      switch (locale.toLanguageTag()) {
        case "zh-CN":
          S.current = const $zhCN();
          return SynchronousFuture<S>(S.current);
        case "en-US":
          S.current = const $enUS();
          return SynchronousFuture<S>(S.current);
        default:
          S.current = const $zhCN();
          return SynchronousFuture<S>(S.current);
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(_CustomLocalizationsDelegate old) => false;

  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in S.supportedLocales) {
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        if (true != withCountry &&
            (supportedLocale.countryCode == null ||
                supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}
