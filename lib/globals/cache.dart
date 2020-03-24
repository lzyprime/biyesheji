import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client/datas/post_data.dart';
import 'package:client/datas/user_data.dart';
import 'package:client/globals/localizations.dart';

class Cache with ChangeNotifier {
  static final _instance = Cache._();

  factory Cache() => _instance;

  Cache._();

  static SharedPreferences shared;

  /// user data
  UserData get userData => shared.containsKey(K.userData)
      ? UserData.fromJson(json.decode(shared.getString(K.userData)))
      : null;

  Future<bool> updateUserData(UserData userData) async {
    if (userData == null || userData.id <= 0) return false;
    bool res =
        await shared.setString(K.userData, json.encode(userData.toJson()));
    notifyListeners();
    return res;
  }

  clearUserData() {
    shared.remove(K.userData);
    notifyListeners();
  }

  /// authCode
  String get authCode => shared.getString(K.authCode);

  updateAuthCode(String newAuthCode) {
    if (newAuthCode == null || newAuthCode.isEmpty) return;
    shared.setString(K.authCode, newAuthCode);
    notifyListeners();
  }

  clearAuthCode() {
    shared.remove(K.authCode);
    notifyListeners();
  }

  /// latest news
  List<PostData> get latestNews => (shared.containsKey(K.latestNews)
      ? shared
          .getStringList(K.latestNews)
          .map((i) => PostData.fromJson(json.decode(i)))
          .toList()
      : [])
    ..sort((a, b) => b.compareTo(a));

  Future<bool> updateLatestNews(List<PostData> latestNews) async {
    if (latestNews == null) return false;
    bool res = await shared.setStringList(
        K.latestNews, latestNews.map((i) => json.encode(i.toJson())).toList());
    notifyListeners();
    return res;
  }

  /// locale
  Locale get locale => shared.containsKey(K.locale)
      ? S.supportedLocales[shared.getInt(K.locale)]
      : null;

  Future<bool> updateLocale(int localeIndex) async {
    if (localeIndex < 0 || localeIndex >= S.supportedLocales.length)
      return false;
    final res = await shared.setInt(K.locale, localeIndex);
    notifyListeners();
    return res;
  }

  clearLocale() {
    shared.remove(K.locale);
    notifyListeners();
  }

  /// theme
  int get primaryIndex => shared.getInt(K.primaryColor) ?? 2;

  int get accentIndex => shared.getInt(K.accentColor) ?? 1;

  ThemeData get theme => ThemeData(
        primarySwatch: Colors.primaries[primaryIndex],
        primaryColor: Colors.primaries[primaryIndex],
        accentColor: Colors.accents[accentIndex],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.primaries[primaryIndex],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textTheme: ButtonTextTheme.primary,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.primaries[primaryIndex],
        primaryColor: Colors.primaries[primaryIndex][900],
        accentColor: Colors.accents[accentIndex][700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.primaries[primaryIndex][900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textTheme: ButtonTextTheme.primary,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        ),
      );

  updateTheme(int primaryIndex, int accentIndex) {
    if (primaryIndex >= 0 && primaryIndex < Colors.primaries.length) {
      shared.setInt(K.primaryColor, primaryIndex);
    }

    if (accentIndex >= 0 && accentIndex < Colors.accents.length) {
      shared.setInt(K.accentColor, accentIndex);
    }

    notifyListeners();
  }

  /// theme mode
  ThemeMode get themeMode => ThemeMode.values[shared.getInt(K.themeMode) ?? 0];

  updateThemeMode(ThemeMode themeMode) {
    if (themeMode == null) return;
    shared.setInt(K.themeMode, themeMode.index);
    notifyListeners();
  }

  /// manager
  Future loadCache() async {
    shared = await SharedPreferences.getInstance();
  }

  Future<bool> clearCache() async {
    final res = await shared.clear();
    notifyListeners();
    return res;
  }
}

class K {
  static const userData = "user_data";
  static const posts = "posts";
  static const latestNews = "latest_news";
  static const authCode = "auth_code";
  static const locale = "locale";
  static const primaryColor = "primary_color";
  static const accentColor = "accent_color";
  static const themeMode = "theme_mode";
}
