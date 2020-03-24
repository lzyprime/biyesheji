import 'package:client/globals/cache.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import 'package:client/globals/route.dart';
import 'package:client/datas/post_data.dart';
import 'package:client/models/post_model.dart';

class EditPostViewModel with ChangeNotifier {
  final _postModel = PostModel();

  int get uid => Cache().userData?.id ?? 0;
  final PostData postData;

  EditPostViewModel({PostData postData})
      : this.postData = postData ?? PostData();

  bool get done => postData.title.isNotEmpty && postData.content.isNotEmpty;

  editPost(BuildContext context) {
    _postModel
        .editPost(postData.id, postData.title, postData.content)
        .doOnData((res) {
          print(res.msg);
      if (res.result == 0) {
        final newPost = PostData.fromJson(res.data);
        Navigator.of(context).pushReplacementNamed(R.post, arguments: newPost);
      }
    }).listen(null);
  }
}
