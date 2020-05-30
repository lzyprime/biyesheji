import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:client/datas/post_data.dart';
import 'package:client/globals/cache.dart';
import 'package:client/models/post_model.dart';

class LatestNewsViewModel with ChangeNotifier {
  final _model = PostModel();

  List<PostData> get data => Cache().latestNews;
  bool loading = false;

  LatestNewsViewModel() {
    refresh();
  }

  Future<void> refresh() async {
    if (loading) return;

    _model.postList().doOnListen(() {
      loading = true;
      notifyListeners();
    }).doOnDone(() {
      loading = false;
      notifyListeners();
    }).doOnData((res) {
      if (res.result == 0) {
        Cache().updateLatestNews((res.data as List).map((i) => PostData.fromJson(i)).toList());
        notifyListeners();
      }
    }).listen(null);
  }
}
