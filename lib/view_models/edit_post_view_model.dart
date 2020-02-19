import 'package:client/view_models/show_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:client/globals/route.dart';
import 'package:client/datas/post_data.dart';
import 'package:client/models/post_model.dart';

class EditPostViewModel with ChangeNotifier {
  final _postModel = PostModel();

  int uid;
  PostData postData;

  EditPostViewModel(this.uid, {PostData postData})
      : this.postData = postData ?? PostData(),
        assert(uid != 0);

  bool get done => postData.title.isNotEmpty && postData.content.isNotEmpty;

  editPost(BuildContext context) {
    _postModel
        .editPost(
      postData.id,
      postData.title,
      postData.content,
      uid,
    )
        .doOnData((res) {
      if (res.result == 0) {
        Navigator.of(context).pushReplacementNamed(R.post,
            arguments: ShowPostViewModel(PostData.fromJson(res.data)));
      }
    }).listen(null);
  }
}
