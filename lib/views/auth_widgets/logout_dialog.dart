import 'package:client/globals/localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).logout),
      actions: <Widget>[
        FlatButton(
            child: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop()),
        FlatButton(
            child: Icon(Icons.done),
            onPressed: () => Navigator.of(context).pop(true)),
      ],
    );
  }
}
