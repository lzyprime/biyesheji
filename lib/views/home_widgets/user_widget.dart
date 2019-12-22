import 'dart:ui';
import 'package:client/globals/global.dart';
import 'package:client/globals/i18n.dart';
import 'package:client/views/auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/view_models/user_view_model.dart';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserViewModel viewModel = Provider.of(context);

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              alignment: Alignment.topCenter,
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: NestedScrollView(
            headerSliverBuilder: (_, __) => [
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: GlobalColor.goldColor),
                          ),
                          child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.black54,
                              child: InkWell(
                                onTap: () => Navigator.of(context).pushNamed(AuthWidget.routeName),
                                child: Text(
                                  '${S.of(context).login}/${S.of(context).register}',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                expandedHeight: 300,
                backgroundColor: Colors.transparent,
              ),
            ],
            body: _body(),
            ),
          ),
        );
  }

  SingleChildScrollView _body() {
    Widget bodyItem(Widget child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white70,
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
    return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  bodyItem(Column(
                    children: <Widget>[
                      Row(
                        children:[
                          Expanded(
                            child: Text('guanzhu:')
                          ),
                          Expanded(
                            child: Text('fensi')
                          )
                        ],
                      ),
                      ListTile(
                        title: Text('username:'),
                      ),
                      ListTile(
                        title: Text('email:'),
                      ),
                      ListTile(
                        title: Text('phone'),
                      ),
                    ],
                  )),
                ],
              ),
            );
  }
}
