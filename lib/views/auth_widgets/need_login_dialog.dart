import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:client/globals/route.dart';
import 'package:client/globals/localizations.dart';

class LoginDialog {
  final _builder = (context) => AlertDialog(
        title: Text(S.of(context).login),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(R.login),
              child: Text(S.of(context).login))
        ],
      );

  LoginDialog(BuildContext _context) {
    showDialog(context: _context, builder: _builder);
  }
}
