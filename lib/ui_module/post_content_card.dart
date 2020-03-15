import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PostContentCard extends StatelessWidget {
  final String title;
  final String content;

  PostContentCard(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 20),
        Text(title, style: Theme.of(context).textTheme.headline),
        Divider(),
        Markdown(
          data: content,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
      ],
    ));
  }
}
