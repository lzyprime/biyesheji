import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/datas/post_data.dart';
import 'package:client/views/post_widgets/post_column.dart';

class PreviewPostWidget extends StatelessWidget {
  final PostData _data;

  PreviewPostWidget(this._data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_data.title)),
        body: PostColumn(_data.title, _data.content));
  }
}
