import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/view_models/auth_view_model.dart';
import 'package:client/views/auth_widgets/login_widget.dart';
import 'package:client/views/auth_widgets/register_widget.dart';

class AuthWidget extends StatefulWidget {
  final _authViewModel = AuthViewModel();
  static const routeName = 'AuthWidget';

  @override
  createState() => _AuthWidgetState(_authViewModel);
}

class _AuthWidgetState extends State<AuthWidget> {
  int current = 0;
  final pageController = PageController();
  final select = [true, false];
  final AuthViewModel viewModel;
  _AuthWidgetState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Scaffold(
            appBar: AppBar(
              title: Text('${S.of(context).login}/${S.of(context).register}'),
              centerTitle: true,
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  child: ToggleButtons(
                    children: [
                      Text(S.of(context).login),
                      Text(S.of(context).register)
                    ],
                    isSelected: select,
                    onPressed: (index) {
                      pageController.animateToPage(
                        index,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    children: <Widget>[LoginWidget(), RegisterWidget()],
                    onPageChanged: (index) => setState((){
                      select[current] = false;
                      select[index] = true;
                      current = index;
                    }),
                  ),
                )
              ],
            )));
  }
}
