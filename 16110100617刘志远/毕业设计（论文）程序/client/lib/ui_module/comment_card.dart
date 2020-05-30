import 'package:flutter/material.dart';

import 'package:client/globals/cache.dart';
import 'package:client/datas/comment_data.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/globals/route.dart';

class CommentCard extends StatelessWidget {
  final CommentData commentData;
  final Function remove;

  CommentCard(this.commentData, {this.remove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: commentData.userData.avatar.isNotEmpty
              ? NetworkImage(commentData.userData.avatar)
              : null,
          child: commentData.userData.avatar.isEmpty ? FlutterLogo() : null,
        ),
        title: Text(commentData.userData.username),
        subtitle: Text(commentData.content,
            maxLines: 1, overflow: TextOverflow.ellipsis),
        children: <Widget>[
          Text("${S.of(context).post}: ${commentData.post.title}"),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "${S.of(context).comment}: ${commentData.content}",
              maxLines: null,
            ),
          ),
          SizedBox(height: 20),
          Text(commentData.dateTime),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(R.post, arguments: commentData.post),
                  child: Text(S.of(context).post)),
              RaisedButton(
                  onPressed: commentData.userData.id !=
                          Cache().userData?.id
                      ? () => Navigator.of(context)
                          .pushNamed(R.user, arguments: commentData.userData)
                      : null,
                  child: Text(
                      "${S.of(context).author}:${commentData.userData.username}")),
              RaisedButton(
                  onPressed: commentData.userData.id == Cache().userData?.id ||
                          commentData.post.userData.id == Cache().userData?.id
                      ? remove
                      : null,
                  child: Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
