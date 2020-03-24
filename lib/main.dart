import 'package:client/globals/cache.dart';
import 'package:flutter/material.dart';

import 'package:client/globals/route.dart';
import 'package:client/globals/localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Cache().loadCache().then((_) => runApp(
        ChangeNotifierProvider.value(
          value: Cache(),
          child: Consumer<Cache>(
            builder: (context, cache, __) => MaterialApp(
              theme: cache.theme,
              darkTheme: cache.darkTheme,
              themeMode: cache.themeMode,
              onGenerateRoute: onGenerateRoute,
              localizationsDelegates: S.localizationsDelegates,
              supportedLocales: S.supportedLocales,
              locale: cache.locale,
              debugShowCheckedModeBanner: false,
              initialRoute: initialRoute,
            ),
          ),
        ),
      ));
}
