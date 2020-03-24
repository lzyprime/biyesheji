import 'package:client/globals/route.dart';
import 'package:client/ui_module/enter_dialog.dart';
import 'package:flutter/material.dart';

import 'package:client/models/user_model.dart';
import 'package:client/ui_module/input_dialog.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/globals/cache.dart';
import 'package:client/datas/user_data.dart';

class SettingsViewModel with ChangeNotifier {
  UserData get userData => Cache().userData;
  final _model = UserModel();

  editUsername(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => InputDialog(
            title: S.of(context).username,
            initText: userData.username,
            maxLength: 13)).then((v) {
      if (v == null || v == userData.username) return;
      _model.newUsername(v).listen((res) {
        if (res.result == 0) {
          userData.username = v;
          Cache().updateUserData(userData);
          notifyListeners();
        } else {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(res.msg ?? "")));
          if (res.result == -105) {
            Cache().clearUserData();
            Cache().clearAuthCode();
            Navigator.of(context).pushReplacementNamed(R.login);
          }
        }
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
                    selected: userData.sex == EnumSex.obscure,
                    onTap: () => Navigator.of(context).pop(EnumSex.obscure),
                  ),
                  ListTile(
                    title: Text(S.of(context).male),
                    selected: userData.sex == EnumSex.male,
                    onTap: () => Navigator.of(context).pop(EnumSex.male),
                  ),
                  ListTile(
                    title: Text(S.of(context).female),
                    selected: userData.sex == EnumSex.female,
                    onTap: () => Navigator.of(context).pop(EnumSex.female),
                  ),
                ],
              ),
            )).then((v) {
      if (v is EnumSex && v != userData.sex)
        _model.newSex(userData.id, v.index).listen((res) {
          if (res.result == 0) {
            userData.sex = v;
            Cache().updateUserData(userData);
            notifyListeners();
          } else {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(res.msg ?? "")));
            if (res.result == -105) {
              Cache().clearUserData();
              Cache().clearAuthCode();
              Navigator.of(context).pushReplacementNamed(R.login);
            }
          }
        });
    });
  }

  logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => EnterDialog(Text(S.of(context).logout))).then((v) {
      if (v == true) {
        Cache().clearUserData();
        Cache().clearAuthCode();
        Navigator.of(context).pop();
      }
    });
  }

  setAvatar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          InputDialog(title: S.of(context).avatar, initText: userData.avatar),
    ).then((v) {
      if (v != null && v != userData.avatar)
        _model.newAvatar(v).listen((res) {
          if (res.result == 0) {
            userData.avatar = v;
            Cache().updateUserData(userData);
            notifyListeners();
          } else {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(res.msg ?? "")));
            if (res.result == -105) {
              Cache().clearUserData();
              Cache().clearAuthCode();
              Navigator.of(context).pushNamed(R.login);
            }
          }
        });
    });
  }

  newPassword(BuildContext context) {
    showDialog(
            context: context,
            builder: (context) =>
                InputDialog(title: S.of(context).password, obscureText: true))
        .then((v) {
      if (v == null || v == "") return;
      _model.newPassword(v).listen((res) {
        if (res.result != 0)
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(res.msg)));
      });
    });
  }

  language(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          ListTile(
              title: Text(
                S.of(context).followSystem,
                textAlign: TextAlign.center,
              ),
              selected: Cache().locale == null,
              onTap: () {
                Cache().clearLocale();
                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text(
                "中文简体",
                textAlign: TextAlign.center,
              ),
              selected: Cache().locale == Locale("zh", "CN"),
              onTap: () {
                Cache().updateLocale(0);
                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text(
                "English",
                textAlign: TextAlign.center,
              ),
              selected: Cache().locale == Locale("en", "US"),
              onTap: () {
                Cache().updateLocale(1);
                Navigator.of(context).pop();
              }),
        ],
      )),
    );
  }

  theme(BuildContext context) {
    int primaryIndex = Cache().primaryIndex;
    int accentIndex = Cache().accentIndex;
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 50),
                Wrap(
                  children: Colors.primaries
                      .asMap()
                      .map((i, color) => MapEntry(
                          i,
                          InkWell(
                            onTap: () => setState(() => primaryIndex = i),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.black,
                                    width: i == primaryIndex ? 2 : 0),
                              ),
                              margin: EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: color,
                              ),
                            ),
                          )))
                      .values
                      .toList(),
                ),
                Divider(height: 20, thickness: 5),
                Wrap(
                  children: Colors.accents
                      .asMap()
                      .map((i, color) => MapEntry(
                          i,
                          InkWell(
                            onTap: () => setState(() => accentIndex = i),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.black,
                                    width: i == accentIndex ? 2 : 0),
                              ),
                              margin: EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: color,
                              ),
                            ),
                          )))
                      .values
                      .toList(),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: RaisedButton(
                      onPressed: () {
                        Cache().updateTheme(primaryIndex, accentIndex);
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.done)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  darkTheme(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          ListTile(
              title: Text(
                S.of(context).followSystem,
                textAlign: TextAlign.center,
              ),
              selected: Cache().themeMode == ThemeMode.system,
              onTap: () {
                Cache().updateThemeMode(ThemeMode.system);
                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text(
                S.of(context).light,
                textAlign: TextAlign.center,
              ),
              selected: Cache().themeMode == ThemeMode.light,
              onTap: () {
                Cache().updateThemeMode(ThemeMode.light);
                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text(
                S.of(context).dark,
                textAlign: TextAlign.center,
              ),
              selected: Cache().themeMode == ThemeMode.dark,
              onTap: () {
                Cache().updateThemeMode(ThemeMode.dark);
                Navigator.of(context).pop();
              }),
        ],
      )),
    );
  }
}
