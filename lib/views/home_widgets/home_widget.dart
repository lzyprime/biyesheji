import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/views/auth_widgets/need_login_dialog.dart';
import 'package:client/view_models/edit_post_view_model.dart';
import 'package:client/globals/route.dart';
import 'package:client/view_models/post_list_view_model.dart';
import 'package:client/view_models/user_view_model.dart';
import 'package:client/views/home_widgets/user_widgets/user_widget.dart';
import 'package:client/views/home_widgets/post_list_widgets/post_list_widget.dart';

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
        ChangeNotifierProvider(create: (_) => PostListViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: Scaffold(
        body: PageView(
          children: [PostListWidget(), UserWidget()],
          controller: _pageController,
          onPageChanged: (index) => setState(() {
            _currentIndex = index;
          }),
        ),
        bottomNavigationBar: Consumer<UserViewModel>(
          builder: (_, viewModel, __) => BottomAppBar(
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
        ),
        floatingActionButton: Consumer<UserViewModel>(
          builder: (_, viewModel, __) => FloatingActionButton(
              onPressed: () {
                if (viewModel.userData == null)
                  LoginDialog(context);
                else
                  Navigator.of(context).pushNamed(R.editPost,
                      arguments: EditPostViewModel(viewModel.userData.id));
              },
              child: Icon(Icons.add)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
