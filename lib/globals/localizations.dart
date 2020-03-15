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

  String get phone => "手机";

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

  String get oldPassword => "旧密码";

  String get editUserInfo => "编辑用户信息";

  String get language => "语言";

  String get theme => "主题";

  String get avatar => "头像";
}

class $zhCN extends S {
  const $zhCN();
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
