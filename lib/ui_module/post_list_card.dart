import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/globals/route.dart';
import 'package:client/datas/post_data.dart';
import 'package:client/ui/post/view_model.dart';
import 'package:client/globals/localizations.dart';

class PostListCard extends StatelessWidget {
  final PostData data;

  PostListCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .pushNamed(R.post, arguments: data);
        },
        title: Text(data.title),
        subtitle: Text("${S.of(context).author}: ${data.userData.username}"),
        trailing: Column(children: <Widget>[
          Text("${S.of(context).updateTime}:"),
          Text(data.updateTime),
        ]),
        contentPadding: EdgeInsets.all(20),
      ),
    );
  }
}
