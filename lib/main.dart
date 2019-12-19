import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/globals/global.dart';
import 'package:client/views/home_widgets/home_widget.dart';
import 'package:client/view_models/user_view_model.dart';

void main()  => runApp(MyApp());

class MyApp extends StatelessWidget with Global {

  @override
  Widget build(BuildContext context) {
    Global.init();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserViewModel()),
      ],
      child: MaterialApp(
        title: 'flutter client',
        theme: theme,
        routes: routes,
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        initialRoute: HomeWidget.routeName,
      ),
    );
  }
}
