import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/datas/user_data.dart';
import 'package:client/models/user_model.dart';

class UserViewModel with ChangeNotifier {
  final _model = UserModel();

  UserData get userData => _model.userData;
  
  logout() {
    _model.logout();
    notifyListeners();
  }

}
