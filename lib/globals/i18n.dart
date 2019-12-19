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

  String get enterPassword => "确认密码";

  String get email => "邮箱";

  String get phone => "手机";

  String get obscure => "保密";

  String get male => "男";

  String get female => "女";

  String get edit => "编辑";

  String get userInfo => "用户信息";

  String get notNull => "不能为空";

  String get inconsistent => "不一致";

  String get netError => "网络请求失败";
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

        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}
