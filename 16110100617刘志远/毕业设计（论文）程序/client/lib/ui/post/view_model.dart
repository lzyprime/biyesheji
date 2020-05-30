import 'package:client/models/post_model.dart';
import 'package:client/ui_module/enter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'package:client/globals/cache.dart';
import 'package:client/datas/post_data.dart';
import 'package:client/models/favorite_model.dart';

class PostViewModel with ChangeNotifier {
  final _favoriteModel = FavoriteModel();

  int get uid => Cache().userData?.id ?? 0;
  final PostData postData;

  bool get isSelfPost => uid != 0 && postData.userData.id == uid;

  bool favorite = false;
  int favoriteLoading = 0; // 0 normal, 1 loading, 2 failed
  PostViewModel(this.postData) {
    getFavorite();
  }

  getFavorite() {
    if (uid == 0 || isSelfPost) return;
    _favoriteModel.postFavoriteStatus(uid, postData.id).doOnListen(() {
      favoriteLoading = 1;
      notifyListeners();
    }).listen((res) {
      favoriteLoading = res == null || res.result != 0 ? 2 : 0;
      favorite = res.data ?? false;
      notifyListeners();
    });
  }

  changeFavorite() {
    _favoriteModel.changePostFavorite(uid, postData.id).doOnListen(() {
      favoriteLoading = 1;
      notifyListeners();
    }).listen((res) {
      favoriteLoading = 0;
      if (res.result == 0) favorite = res.data;
      notifyListeners();
    });
  }

  removePost(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EnterDialog(Icon(Icons.delete)),
    ).then((res) {
      if (res == true)
        PostModel().removePost(postData.id).listen((res) {
          if (res.result == 0) Navigator.pop(context);
        });
    });
  }
}
