import 'package:flutter/cupertino.dart';

import 'package:client/datas/post_data.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/favorite_model.dart';

class ShowPostViewModel with ChangeNotifier {
  final _favoriteModel = FavoriteModel();

  int get uid => UserModel().userData?.id ?? 0;
  final PostData postData;

  bool get isSelfPost => uid != 0 && postData.userData.id == uid;

  bool favorite = false;

  ShowPostViewModel(this.postData)
      : assert(postData != null &&
            postData.id != 0 &&
            postData.userData != null &&
            postData.userData.id != 0) {
    if (uid != 0 && !isSelfPost)
      getFavorite();
  }

  getFavorite() {
    _favoriteModel.postFavoriteStatus(uid, postData.id).listen((res){
      favorite = res.data ?? false;
      notifyListeners();
    });
  }

  changeFavorite() {
    _favoriteModel.changePostFavorite(uid, postData.id).listen((res) {
      if (res.result == 0) {
        favorite = res.data ?? false;
        notifyListeners();
      }
    });
  }
}
