import 'package:flutter/material.dart';

import 'package:client/views/empty_widget.dart';
import 'package:client/views/home_widgets/user_widget.dart';

class HomeWidget extends StatefulWidget {
  static const routeName = 'HomeWidget';

  @override
  createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> {
  final _children = [EmptyWidget(), EmptyWidget(), EmptyWidget(), UserWidget()];
  final _pageController = PageController();
  List<BottomNavigationBarItem> _items;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        title: Text("最新动态"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.widgets),
        title: Text(""),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.widgets),
        title: Text(""),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text("我"),
      ),
    ];
  }

  @override
  build(BuildContext context) => Scaffold(
      body: PageView(
        children: _children,
        controller: _pageController,
        onPageChanged: (index) => setState(() {
            _currentIndex = index;
          }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _items,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        fixedColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        showUnselectedLabels: true,
      ));
}
