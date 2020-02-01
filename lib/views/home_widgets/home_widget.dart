import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/views/empty_widget.dart';
import 'package:client/view_models/user_view_model.dart';
import 'package:client/views/user_widgets/user_widget.dart';
import 'package:client/views/auth_widgets/auth_widget.dart';

class HomeWidget extends StatefulWidget {
  static const routeName = 'HomeWidget';

  @override
  createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> {
  final _children = [EmptyWidget(), UserWidget()];
  final _items = [Icon(Icons.list), Icon(Icons.person)];
  final _pageController = PageController();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserViewModel()),
        ],
        child: Scaffold(
          body: PageView(
            children: _children,
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
                Navigator.of(context).pushNamed(AuthWidget.routeName);
              },
              child: Icon(Icons.add)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      );
}
