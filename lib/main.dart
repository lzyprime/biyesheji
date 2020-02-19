import 'package:flutter/material.dart';

import 'package:client/globals/route.dart';
import 'package:client/globals/localizations.dart';

void main() => runApp(MaterialApp(
      theme: _theme,
      onGenerateRoute: onGenerateRoute,
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
    ));

final _theme = ThemeData(
  primarySwatch: Colors.purple,
  primaryColor: Colors.purple,
  accentColor: Colors.pink,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.purple,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    textTheme: ButtonTextTheme.primary,
  ),
);
