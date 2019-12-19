import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:client/view_models/user_view_model.dart';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserViewModel viewModel = Provider.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          expandedHeight: 400,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 1000,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
