import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:client/datas/post_data.dart';
import 'package:client/models/post_model.dart';

class PostListViewModel with ChangeNotifier {
  final _model = PostModel();
  final List<PostData> data = [];
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool v) {
    _loading = v;
    notifyListeners();
  }

  PostListViewModel() {
    refresh();
  }

  Future<void> refresh() async {
    if (loading) return;

    _model
        .postList()
        .doOnListen(() => loading = true)
        .doOnDone(() => loading = false)
        .doOnData((res) {
      if (res.result == 0) {
        data.addAll(
            (res.data as List).map((i) => PostData.fromJson(i)));
        notifyListeners();
      }
    }).listen(null);
  }
}
