import 'package:flutter/material.dart';

import 'package:client/models/user_model.dart';
import 'package:client/ui_module/input_dialog.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/globals/cache.dart';
import 'package:client/datas/user_data.dart';

class SettingsViewModel with ChangeNotifier {
  UserData get userdata => Cache().userData;
  final _model = UserModel();

  editUsername(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => InputDialog(
            title: S.of(context).username,
            initText: userdata.username,
            maxLength: 13)).then((v) {
      if (v == null || v == userdata.username) return;
      _model.newUsername(userdata.id, v).listen((res) {
        if (res.result == 0) {
          userdata.username = v;
          Cache.update(K.userInfo, userdata);
          notifyListeners();
        } else
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(res.msg ?? "")));
      });
    });
  }

  newSex(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(S.of(context).obscure),
                    selected: userdata.sex == EnumSex.obscure,
                    onTap: () => Navigator.of(context).pop(EnumSex.obscure),
                  ),
                  ListTile(
                    title: Text(S.of(context).male),
                    selected: userdata.sex == EnumSex.male,
                    onTap: () => Navigator.of(context).pop(EnumSex.male),
                  ),
                  ListTile(
                    title: Text(S.of(context).female),
                    selected: userdata.sex == EnumSex.female,
                    onTap: () => Navigator.of(context).pop(EnumSex.female),
                  ),
                ],
              ),
        )).then((v) {
      if (v is EnumSex && v != userdata.sex)
        _model.newSex(userdata.id, v.index).listen((res) {
          if (res.result == 0) {
            userdata.sex = v;
            Cache.update(K.userInfo, userdata);
            notifyListeners();
          } else
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(res.msg ?? "")));
        });
    });
  }
}
