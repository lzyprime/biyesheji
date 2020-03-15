import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/cache.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/ui_module/enter_dialog.dart';
import 'package:client/ui/latest_news/latest_news_widget.dart';
import 'package:client/ui/user/view_model.dart';
import 'package:client/ui/user/user_widget.dart';
import 'package:client/globals/route.dart';
import 'package:client/ui/latest_news/view_model.dart';

class HomeWidget extends StatefulWidget {
  @override
  createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final _items = [Icon(Icons.list), Icon(Icons.person)];
  final _pageController = PageController();
  int _currentIndex = 0;

  @override
  build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LatestNewsViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: Scaffold(
        body: PageView(
          children: [LatestNewsWidget(), UserWidget()],
          controller: _pageController,
          onPageChanged: (index) => setState(() {
            _currentIndex = index;
          }),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            children: List.generate(
                _items.length,
                (i) => Expanded(
                      child: IconButton(
                          icon: _items[i],
                          onPressed: () {
                            _pageController.jumpToPage(i);
                          },
                          color: _currentIndex == i
                              ? Theme.of(context).primaryColor
                              : null),
                    )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (Cache().userData == null)
                showDialog(
                    context: context,
                    builder: (_) => EnterDialog(S.of(context).login)).then((v) {
                  if (v == true) Navigator.of(context).pushNamed(R.login);
                });
              else
                Navigator.of(context).pushNamed(R.editPost);
            },
            child: Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
