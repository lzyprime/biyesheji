import 'package:flutter/material.dart';

import 'package:client/models/user_model.dart';

class UserViewModel with ChangeNotifier {
  final _model = UserModel();

  String get username =>  "";

  int get sex => 1;

  String get email =>  "";

  String get phone =>  "";

  String get avatar =>  "";


  UserViewModel() {
    getUserInfo();
  }

  void getUserInfo() => _model.getUserInfo().listen((data) {
        notifyListeners();
      });

}
