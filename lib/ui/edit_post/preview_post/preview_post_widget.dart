import 'package:client/ui_module/post_content_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/datas/post_data.dart';

class PreviewWidget extends StatelessWidget {
  final PostData _data;

  PreviewWidget(this._data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_data.title)),
        body: PostContentCard(_data.title, _data.content));
  }
}
