import 'package:flutter/material.dart';

import 'package:client/models/user_model.dart';

class UserViewModel with ChangeNotifier {
  final _model = UserModel();

  UserViewModel() {
    getUserInfo();
  }

  void getUserInfo() => _model.getUserInfo().listen((data) {
        notifyListeners();
      });

}
